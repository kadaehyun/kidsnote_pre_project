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
	}
	
	// MARK: - Initialize
	
	@available(*, unavailable) required convenience init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
			case let .eBookInfo(description):
				let cell = collectionView.dequeue(Reusable.detailEBookInfoCell, for: indexPath)
				
				cell.configure(description: description)
				
				return cell
			case let .publishedDate(volumeInfo):
				let cell = collectionView.dequeue(Reusable.detailPublishedDateCell, for: indexPath)
				
				cell.configure(volumeInfo: volumeInfo)
				
				return cell
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
}
