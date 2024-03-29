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
import ReactorKit

final class DetailViewController: UIViewController, View {
	
	// MARK: - Constants
	
	// MARK: - Properties
	
	var disposeBag = DisposeBag()
	
	// MARK: - UI
	
	private let contentView = UIView().then {
		$0.backgroundColor = .white
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
		self.navigationController?.isNavigationBarHidden = false
	}

	override func viewWillDisappear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
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
	
	// MARK: - Bind

	func bind(reactor: DetailViewReactor) {
		
	}
}

// MARK: - Layout

private extension DetailViewController {
	func defineFlexContainer() {
		self.contentView.flex
			.direction(.column)
			.define {
				$0.addItem(self.collectionView).grow(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.all(0)
		self.contentView.flex.layout()
	}
}
