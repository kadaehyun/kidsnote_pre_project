//
//  SearchListHeaderReusableView.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/28/24.
//

import Foundation
import UIKit
import FlexLayout
import Then

public final class SearchListHeaderReusableView: UICollectionReusableView {
	
	// MARK: - Constants

	// MARK: - Properties

	// MARK: - UI
	
	// MARK: - Initialize
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.defineFlexContainer()
	}
	
	@available(*, unavailable) required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life Cycle
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		self.layoutFlexContainer()
	}

	deinit {
		print("SearchListHeaderReusableView deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension SearchListHeaderReusableView {
	func defineFlexContainer() {
	}
	
	func layoutFlexContainer() {
		self.flex.layout()
	}
}
