//
//  DetailEBookInfoCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class DetailEBookInfoCell: UICollectionViewCell {
	
	// MARK: - Constants
	
	// MARK: - Properties

	// MARK: - UI
	
	private let titleLabel = UILabel().then {
		$0.font = .boldSystemFont(ofSize: 16)
		$0.textColor = .black
		$0.text = "eBook 정보"
	}
	
	private let arrowLabel = UILabel().then {
		$0.font = .boldSystemFont(ofSize: 16)
		$0.textColor = .blue
		$0.text = "〉"
	}
	
	private let descriptionLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 14)
		$0.textColor = .darkGray
		$0.numberOfLines = 4
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
		print("DetailEBookInfoCell deinit...")
	}

	// MARK: - Configure

	func configure(description: String) {
		self.descriptionLabel.text = description
		self.descriptionLabel.flex.markDirty()
		
		self.setNeedsLayout()
	}
	
	// MARK: - Logic
}

// MARK: - Layout

private extension DetailEBookInfoCell {
	func defineFlexContainer() {
		self.contentView.flex
			.paddingHorizontal(20)
			.paddingVertical(18)
			.define {
				self.titleFlexLayout($0).height(22)
				$0.addItem(self.descriptionLabel).shrink(1).grow(1).marginTop(8)
			}
	}
	
	@discardableResult private func titleFlexLayout(_ flex: Flex) -> Flex {
		flex.addItem()
			.direction(.row)
			.justifyContent(.spaceBetween)
			.define {
				$0.addItem(self.titleLabel)
				$0.addItem(self.arrowLabel)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
