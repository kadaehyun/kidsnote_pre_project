//
//  DetailViewController.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/28/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit
import ReactorKit
import ReusableKit
import RxDataSources

final class DetailViewController: UIViewController, View {
	
	// MARK: - Constants
	
	private enum Reusable {
		static let detailVolumeInfoCell = ReusableCell<DetailVolumeInfoCell>()
		static let detailEBookInfoCell = ReusableCell<DetailEBookInfoCell>()
		static let detailPublishedDateCell = ReusableCell<DetailPublishedDateCell>()
		static let lineReusableView = ReusableView<UICollectionReusableView>()
	}
	
	// MARK: - Properties
	
	private lazy var dataSource = self.createDataSource()
	var disposeBag = DisposeBag()
	
	// MARK: - UI
	
	private let contentView = UIView().then {
		$0.backgroundColor = .white
	}
	
	private let collectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: UICollectionViewFlowLayout()
	)
	.then {
		$0.alwaysBounceVertical = true
		$0.showsVerticalScrollIndicator = false
		$0.register(Reusable.detailVolumeInfoCell)
		$0.register(Reusable.detailEBookInfoCell)
		$0.register(Reusable.detailPublishedDateCell)
		$0.register(Reusable.lineReusableView, kind: .footer)
	}
	
	// MARK: - Initialize
	
	@available(*, unavailable) required convenience init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
		self.navigationItem.backBarButtonItem = backBarButtonItem
		
		self.view.backgroundColor = .white
		
		self.view.addSubview(self.contentView)
		
		self.defineFlexContainer()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = false
	}

	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.layoutFlexContainer()
	}
	
	deinit {
		print("DetailViewController deinit...")
	}

	// MARK: - Configure

	private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<DetailViewSection> {
		.init(configureCell: { _, collectionView, indexPath, sectionItem in
			switch sectionItem {
			case let .volumeInfo(volumeInfo):
				let cell = collectionView.dequeue(Reusable.detailVolumeInfoCell, for: indexPath)
				
				cell.configure(volumeInfo: volumeInfo)
				
				return cell
			case let .eBookInfo(volumeInfo):
				let cell = collectionView.dequeue(Reusable.detailEBookInfoCell, for: indexPath)
				
				cell.configure(description: volumeInfo.description ?? "")
				
				return cell
			case let .publishedDate(volumeInfo):
				let cell = collectionView.dequeue(Reusable.detailPublishedDateCell, for: indexPath)
				
				cell.configure(volumeInfo: volumeInfo)
				
				return cell
			}
		}, configureSupplementaryView: { [weak self] _, collectionView, kind, indexPath in
			guard let self else { return collectionView.emptyView(for: indexPath, kind: kind) }
			guard kind == UICollectionView.elementKindSectionFooter else {
				return collectionView.emptyView(for: indexPath, kind: kind)
			}
			
			let section = self.dataSource[indexPath.section].identity

			switch section {
			case .volumeInfo:
				let view = collectionView.dequeue(Reusable.lineReusableView, kind: kind, for: indexPath)

				view.backgroundColor = .lightGray
				
				return view
			default:
				return collectionView.emptyView(for: indexPath, kind: kind)
			}
		})
	}
	
	// MARK: - Logic
	
	// MARK: - Bind

	func bind(reactor: DetailViewReactor) {
		self.bindCollectionView(reactor: reactor)
	}
	
	private func bindCollectionView(reactor: DetailViewReactor) {
		self.collectionView.rx
			.setDelegate(self)
			.disposed(by: self.disposeBag)
		
		reactor.state
			.map { $0.sections }
			.bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
			.disposed(by: self.disposeBag)
		
		self.collectionView.rx
			.itemSelected
			.withUnretained(self)
			.subscribe(onNext: { owner, indexPath in
				let sectionItem = owner.dataSource[indexPath]
				
				guard case let .eBookInfo(volumeInfo) = sectionItem else { return }
				
				let viewController = EBookInfoViewController()
				viewController.volumeInfo = volumeInfo
				
				owner.navigationController?.pushViewController(viewController, animated: true)
			})
			.disposed(by: self.disposeBag)
	}
}

// MARK: - Layout

private extension DetailViewController {
	func defineFlexContainer() {
		self.contentView.flex
			.direction(.column)
			.define {
				$0.addItem(self.collectionView).grow(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.all(0)
		self.contentView.flex.layout()
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let sectionItem = self.dataSource[indexPath]
		
		switch sectionItem {
		case .volumeInfo:
			return CGSize(width: UIScreen.main.bounds.width, height: 164)
		case .eBookInfo:
			return CGSize(width: UIScreen.main.bounds.width, height: 150)
		case .publishedDate:
			return CGSize(width: UIScreen.main.bounds.width, height: 78)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		let section = self.dataSource[section].identity

		switch section {
		case .volumeInfo:
			return CGSize(width: UIScreen.main.bounds.width, height: 1)
		default:
			return .zero
		}
	}
}
