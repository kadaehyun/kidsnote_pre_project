//
//  EBookInfoViewController.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit

final class EBookInfoViewController: UIViewController {
	
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
		print("EBookInfoViewController deinit...")
	}

	// MARK: - Configure

	// MARK: - Logic
}

// MARK: - Layout

private extension EBookInfoViewController {
	func defineFlexContainer() {
	}
	
	func layoutFlexContainer() {
		self.view.flex.layout()
	}
}
