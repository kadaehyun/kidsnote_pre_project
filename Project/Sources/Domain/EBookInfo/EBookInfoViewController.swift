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
	
	// MARK: - Properties
	
	var volumeInfo: VolumeInfo?
	
	// MARK: - UI
	
	private let contentView = UIView().then {
		$0.backgroundColor = .white
	}
	
	private let descriptionTextView = UITextView().then {
		$0.font = .systemFont(ofSize: 14)
		$0.textColor = .darkGray
	}
	
	// MARK: - Initialize
	
	@available(*, unavailable) required convenience init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.title = volumeInfo?.title
		
		self.view.backgroundColor = .white
		self.view.addSubview(self.contentView)
		
		self.defineFlexContainer()
		
		self.descriptionTextView.text = volumeInfo?.description
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		self.layoutFlexContainer()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = false
	}

	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	deinit {
		print("EBookInfoViewController deinit...")
	}
}

// MARK: - Layout

private extension EBookInfoViewController {
	func defineFlexContainer() {
		self.contentView.flex
			.direction(.column)
			.paddingHorizontal(20)
			.define {
				$0.addItem(self.descriptionTextView).grow(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.all(0)
		self.contentView.flex.layout()
	}
}
