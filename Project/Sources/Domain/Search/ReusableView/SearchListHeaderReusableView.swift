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
	
	private let contentView = UIView()
	
	private let titleLabel = UILabel().then {
		$0.font = .boldSystemFont(ofSize: 18)
		$0.textColor = .black
	}
	
	// MARK: - Initialize
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = .white
		
		self.addSubview(self.contentView)
		
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
		self.contentView.flex
			.justifyContent(.center)
			.paddingHorizontal(20)
			.define {
				$0.addItem(self.titleLabel).shrink(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.all()
		self.contentView.flex.layout()
	}
}
