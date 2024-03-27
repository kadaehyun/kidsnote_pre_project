//
//  SearchViewController.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class SearchViewController: UIViewController {
	
	// MARK: - Constants
	
	// MARK: - Properties
	
	// MARK: - UI
	
	// MARK: - Initialize
	
	@available(*, unavailable) required convenience init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .white
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.layoutFlexContainer()
	}
	
	deinit {
		print("SearchViewController deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension SearchViewController {
	func defineFlexContainer() {
	}
	
	func layoutFlexContainer() {
		self.view.flex.layout()
	}
}
