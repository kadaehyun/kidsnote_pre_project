//
//  LibraryItemCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/30/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class LibraryItemCell: UICollectionViewCell {
	
	// MARK: - Constants
	
	// MARK: - Properties

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
		$0.font = .systemFont(ofSize: 12)
		$0.textColor = .darkGray
	}
	
	private let authorsLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 12)
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
	}
	
	deinit {
		print("LibraryItemCell deinit...")
	}

	// MARK: - Configure

	func configure(item: BooksItem) {
		self.titleLabel.text = item.volumeInfo?.title
		self.authorsLabel.text = item.volumeInfo?.authors?.first

		if let urlString = item.volumeInfo?.imageLinks?.thumbnail, let url = URL(string: urlString) {
			self.thumbnailImageView.imageDownload(url: url)
		} else {
			self.thumbnailImageView.image = nil
		}
		
		self.titleLabel.flex.markDirty()
		self.authorsLabel.flex.markDirty()
		
		self.setNeedsLayout()
	}
	
	// MARK: - Logic
}

// MARK: - Layout

private extension LibraryItemCell {
	func defineFlexContainer() {
		self.contentView.flex
			.define {
				self.thumbnailFlexLayout($0).aspectRatio(150 / 216)
				self.volumeInfoFlexLayout($0).marginTop(4)
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
				$0.addItem(self.authorsLabel).shrink(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
