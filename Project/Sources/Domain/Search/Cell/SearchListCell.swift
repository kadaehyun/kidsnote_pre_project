//
//  SearchListCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/28/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class SearchListCell: UICollectionViewCell {
	
	// MARK: - UI
	
	private let thumbnailShadowView = UIView().then {
		$0.layer.shadowOffset = CGSize(width: 2, height: 2)
		$0.layer.shadowOpacity = 0.5
		$0.layer.shadowRadius = 2
		$0.layer.shadowColor = UIColor.gray.cgColor
	}
	
	private let thumbnailImageView = UIImageView().then {
		$0.contentMode = .scaleAspectFill
		$0.backgroundColor = .clear
		$0.clipsToBounds = true
		$0.layer.cornerRadius = 4
	}
	
	private let titleLabel = UILabel().then {
		$0.font = .boldSystemFont(ofSize: 14)
		$0.textColor = .black
		$0.numberOfLines = 2
	}
	
	private let authorsLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 10)
		$0.textColor = .darkGray
	}
	
	private let printTypeLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 10)
		$0.textColor = .darkGray
	}
	
	private let averageRatingLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 10)
		$0.textColor = .darkGray
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
		
		self.reset()
	}
	
	deinit {
		print("SearchListCell deinit...")
	}

	// MARK: - Configure

	func configure(item: BooksItem) {
		self.titleLabel.text = item.volumeInfo?.title
		self.authorsLabel.text = item.volumeInfo?.authors?.first
		self.printTypeLabel.text = item.volumeInfo?.printType
		
		if let averageRating = item.volumeInfo?.averageRating {
			self.averageRatingLabel.text = "\(averageRating) ★"
		} else {
			self.averageRatingLabel.text = nil
		}
		
		if let urlString = item.volumeInfo?.imageLinks?.smallThumbnail, let url = URL(string: urlString) {
			self.thumbnailImageView.imageDownload(url: url)
		} else {
			self.thumbnailImageView.image = nil
		}
		
		self.titleLabel.flex.markDirty()
		self.authorsLabel.flex.markDirty()
		self.printTypeLabel.flex.markDirty()
		self.averageRatingLabel.flex.markDirty()
		
		self.setNeedsLayout()
	}
	
	// MARK: - Logic
	
	private func reset() {
		self.titleLabel.text = nil
		self.authorsLabel.text = nil
		self.printTypeLabel.text = nil
		self.averageRatingLabel.text = nil
		self.thumbnailImageView.image = nil
	}
}

// MARK: - Layout

private extension SearchListCell {
	func defineFlexContainer() {
		self.contentView.flex
			.direction(.row)
			.paddingHorizontal(20)
			.define {
				self.thumbnailFlexLayout($0).aspectRatio(42 / 60).marginVertical(10)
				self.volumeInfoFlexLayout($0).marginLeft(14).marginTop(10).marginBottom(8)
			}
	}
	
	@discardableResult private func thumbnailFlexLayout(_ flex: Flex) -> Flex {
		flex.addItem(self.thumbnailShadowView)
			.define {
				$0.addItem(self.thumbnailImageView).grow(1)
			}
	}
	
	@discardableResult private func volumeInfoFlexLayout(_ flex: Flex) -> Flex {
		flex.addItem()
			.shrink(1)
			.grow(1)
			.alignItems(.start)
			.define {
				$0.addItem(self.titleLabel).shrink(1).marginBottom(2)
				$0.addItem(self.authorsLabel).shrink(1).marginBottom(2)
				self.typeAndRatingFlexLayout($0)
			}
	}
	
	@discardableResult private func typeAndRatingFlexLayout(_ flex: Flex) -> Flex {
		flex.addItem()
			.direction(.row)
			.shrink(1)
			.define {
				$0.addItem(self.printTypeLabel).shrink(1).marginRight(4)
				$0.addItem(self.averageRatingLabel).shrink(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
