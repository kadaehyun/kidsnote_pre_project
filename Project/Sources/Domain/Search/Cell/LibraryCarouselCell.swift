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

final class LibraryCarouselCell: UICollectionViewCell, View {
	
	// MARK: - Constants
	
	// MARK: - Properties

	var disposeBag = DisposeBag()
	
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

	// MARK: - Logic
	
	// MARK: - Bind

	func bind(reactor: LibraryCarouselCellReactor) {
		
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
