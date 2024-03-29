//
//  DetailVolumeInfoCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class DetailVolumeInfoCell: UICollectionViewCell {
	
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
		$0.font = .boldSystemFont(ofSize: 22)
		$0.textColor = .black
		$0.numberOfLines = 3
	}
	
	private let authorsLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 14)
		$0.textColor = .darkGray
	}
	
	private let printTypeLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 14)
		$0.textColor = .darkGray
	}
	
	private let pageCountLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 14)
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
		print("DetailVolumeInfoCell deinit...")
	}

	// MARK: - Configure

	func configure(volumeInfo: VolumeInfo) {
		self.titleLabel.text = volumeInfo.title
		self.authorsLabel.text = volumeInfo.authors?.first
		self.printTypeLabel.text = volumeInfo.printType
		
		if let pageCount = volumeInfo.pageCount {
			self.pageCountLabel.text = " • \(pageCount) 페이지"
		} else {
			self.pageCountLabel.text = nil
		}
		
		if let urlString = volumeInfo.imageLinks?.thumbnail, let url = URL(string: urlString) {
			self.thumbnailImageView.imageDownload(url: url)
		} else {
			self.thumbnailImageView.image = nil
		}
		
		self.titleLabel.flex.markDirty()
		self.authorsLabel.flex.markDirty()
		self.printTypeLabel.flex.markDirty()
		self.pageCountLabel.flex.markDirty()
		
		self.setNeedsLayout()
	}
	
	// MARK: - Logic
}

// MARK: - Layout

private extension DetailVolumeInfoCell {
	func defineFlexContainer() {
		self.contentView.flex
			.direction(.row)
			.paddingHorizontal(20)
			.define {
				self.thumbnailFlexLayout($0).aspectRatio(88 / 124).marginVertical(20)
				self.volumeInfoFlexLayout($0).marginLeft(20).marginTop(20).marginBottom(20)
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
				$0.addItem(self.titleLabel).shrink(1).marginBottom(4)
				$0.addItem(self.authorsLabel).shrink(1).marginBottom(4)
				self.printTypeAndPageCountFlexLayout($0)
			}
	}
	
	@discardableResult private func printTypeAndPageCountFlexLayout(_ flex: Flex) -> Flex {
		flex.addItem()
			.direction(.row)
			.shrink(1)
			.define {
				$0.addItem(self.printTypeLabel).shrink(1)
				$0.addItem(self.pageCountLabel).shrink(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
