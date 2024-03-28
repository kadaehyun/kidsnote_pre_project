//
//  DetailViewController.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/28/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class DetailViewController: UIViewController {
	
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
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.layoutFlexContainer()
	}
	
	deinit {
		print("DetailViewController deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension DetailViewController {
	func defineFlexContainer() {
	}
	
	func layoutFlexContainer() {
		self.view.flex.layout()
	}
}
