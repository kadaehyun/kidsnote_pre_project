//
//  DetailPublishedDateCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class DetailPublishedDateCell: UICollectionViewCell {
	
	// MARK: - Constants
	
	// MARK: - Properties

	// MARK: - UI
	
	private let titleLabel = UILabel().then {
		$0.font = .boldSystemFont(ofSize: 16)
		$0.textColor = .black
		$0.text = "게시일"
	}
	
	private let publishedDateLabel = UILabel().then {
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
		print("DetailPublishedDateCell deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension DetailPublishedDateCell {
	func defineFlexContainer() {
		self.contentView.flex
			.paddingHorizontal(20)
			.paddingVertical(16)
			.define {
				$0.addItem(self.titleLabel)
				$0.addItem(self.publishedDateLabel).marginTop(14).shrink(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
