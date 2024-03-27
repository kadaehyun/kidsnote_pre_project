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
	
	private let contentView = UIView().then {
		$0.backgroundColor = .white
	}
	
	private let textField = UITextField().then {
		$0.borderStyle = .none
		$0.textColor = .darkGray
		$0.placeholder = "Play 북에서 검색"
	}
	
	private let lineView = UIView().then {
		$0.backgroundColor = .lightGray
	}
	
	private let collectionView = UICollectionView(
		frame: .zero,
		collectionViewLayout: UICollectionViewFlowLayout()
	)
	.then {
		$0.alwaysBounceVertical = true
		$0.showsVerticalScrollIndicator = false
	}
	
	// MARK: - Initialize
	
	@available(*, unavailable) required convenience init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = .white
		
		self.view.addSubview(self.contentView)
		
		self.defineFlexContainer()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}

	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = false
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
		self.contentView.flex
			.direction(.column)
			.define {
				$0.addItem(self.textField).height(40).marginHorizontal(12)
				$0.addItem(self.lineView).height(1)
				$0.addItem(self.collectionView).grow(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.top(self.view.pin.safeArea.top).bottom().left().right()
		
		self.contentView.flex.layout()
	}
}
