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
	
	// MARK: - Constants
	
	// MARK: - Properties

	// MARK: - UI
	
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
		print("SearchListCell deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension SearchListCell {
	func defineFlexContainer() {
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}