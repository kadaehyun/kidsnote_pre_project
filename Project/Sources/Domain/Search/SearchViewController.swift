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
import ReactorKit
import RxCocoa

final class SearchViewController: UIViewController, View {
	
	// MARK: - Constants
	
	// MARK: - Properties
	
	var disposeBag = DisposeBag()
	
	// MARK: - UI
	
	private let contentView = UIView().then {
		$0.backgroundColor = .white
	}
	
	private let textField = UITextField().then {
		$0.borderStyle = .none
		$0.textColor = .darkGray
		$0.placeholder = "Play 북에서 검색"
		$0.returnKeyType = .search
		$0.clearButtonMode = .whileEditing
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
	
	private let activityIndicator = UIActivityIndicatorView().then {
		$0.style = .large
		$0.isHidden = true
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
	
	// MARK: - Bind

	func bind(reactor: SearchViewReactor) {
		self.bindLifeCycle(reactor: reactor)
		self.bindTextField(reactor: reactor)
	}
	
	func bindLifeCycle(reactor: SearchViewReactor) {
		reactor.state.map { $0.isLoading }
			.distinctUntilChanged()
			.withUnretained(self)
			.subscribe(onNext: { owner, isLoading in
				DispatchQueue.main.async {
					if isLoading == true {
						owner.activityIndicator.isHidden = false
						owner.activityIndicator.flex.isIncludedInLayout = true
						owner.activityIndicator.startAnimating()
						owner.view.setNeedsLayout()
					} else {
						owner.activityIndicator.stopAnimating()
						owner.activityIndicator.isHidden = true
						owner.activityIndicator.flex.isIncludedInLayout = false
						owner.view.setNeedsLayout()
					}
				}
			})
			.disposed(by: self.disposeBag)
	}
	
	private func bindTextField(reactor: SearchViewReactor) {
		self.textField.rx
			.controlEvent([.editingDidEndOnExit])
			.map { _ in Reactor.Action.search(self.textField.text) }
			.bind(to: reactor.action)
			.disposed(by: self.disposeBag)
	}
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
				$0.addItem(self.activityIndicator).position(.absolute).all(0)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.pin.top(self.view.pin.safeArea.top).bottom().left().right()
		
		self.contentView.flex.layout()
	}
}