//
//  LibraryCarouselCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/30/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit
import ReactorKit
import RxDataSources
import ReusableKit

final class LibraryCarouselCell: UICollectionViewCell, View {
	
	// MARK: - Constants
	
	private enum Reusable {
		static let libraryItemCell = ReusableCell<LibraryItemCell>()
	}
	
	// MARK: - Properties

	private lazy var dataSource = self.createDataSource()
	var disposeBag = DisposeBag()
	var itemSelectedObserver: AnyObserver<BooksItem>?
	
	// MARK: - UI
	
	private let collectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: UICollectionViewFlowLayout().then {
			$0.scrollDirection = .horizontal
			$0.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 20)
			$0.minimumLineSpacing = 12
			$0.minimumInteritemSpacing = 0
		}
	).then {
		$0.showsVerticalScrollIndicator = false
		$0.showsHorizontalScrollIndicator = false
		$0.backgroundColor = .white
		$0.register(Reusable.libraryItemCell)
	}
	
	private let lineView = UIView().then {
		$0.backgroundColor = .lightGray
	}
	
	// MARK: - Initialize
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.defineFlexContainer()
	}
	
	@available(*, unavailable) required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layoutFlexContainer()
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	deinit {
		print("LibraryCarouselCell deinit...")
	}

	// MARK: - Configure

	private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<LibraryCarouselCellSection> {
		.init(configureCell: { _, collectionView, indexPath, sectionItem in
			switch sectionItem {
			case let .library(item):
				let cell = collectionView.dequeue(Reusable.libraryItemCell, for: indexPath)
				
				cell.configure(item: item)
				
				return cell
			}
		})
	}
	
	// MARK: - Bind

	func bind(reactor: LibraryCarouselCellReactor) {
		self.bindCollectionView(reactor: reactor)
		
		reactor.action.onNext(.refresh)
	}
	
	private func bindCollectionView(reactor: LibraryCarouselCellReactor) {
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
				
				switch sectionItem {
				case let .library(item):
					owner.itemSelectedObserver?.onNext(item)
				default:
					break
				}
			})
			.disposed(by: self.disposeBag)
	}
}

// MARK: - Layout

private extension LibraryCarouselCell {
	func defineFlexContainer() {
		self.contentView.flex
			.paddingTop(8)
			.define {
				$0.addItem(self.collectionView).grow(1)
				$0.addItem(self.lineView).marginHorizontal(20).marginTop(20).height(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension LibraryCarouselCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let sectionItem = self.dataSource[indexPath]
		
		switch sectionItem {
		case .library:
			return CGSize(width: 150, height: 247)
		}
	}
}
