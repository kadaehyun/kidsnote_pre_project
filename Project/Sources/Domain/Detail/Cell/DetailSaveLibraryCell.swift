//
//  DetailSaveLibraryCell.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import FlexLayout
import PinLayout
import Then
import UIKit
import RxSwift

final class DetailSaveLibraryCell: UICollectionViewCell {
	
	// MARK: - Properties

	private var disposeBag = DisposeBag()
	private var item: BooksItem?
	
	// MARK: - UI
	
	private let saveButton = UIButton().then {
		$0.setTitle("내 라이브러리에 저장", for: .normal)
		$0.setTitleColor(.white, for: .normal)
		$0.setBackgroundColor(.blue, for: .normal)
		$0.titleLabel?.font = .boldSystemFont(ofSize: 14)
		$0.layer.cornerRadius = 4
		$0.layer.masksToBounds = true
	}
	
	// MARK: - Initialize
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.defineFlexContainer()
		self.bindButtons()
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
		print("DetailSaveLibraryCell deinit...")
	}

	// MARK: - Configure

	func configure(item: BooksItem) {
		self.item = item
	}
	
	// MARK: - Bind
	
	private func bindButtons() {
		self.saveButton.rx.tap
			.withUnretained(self)
			.bind { owner, _ in
				guard let item = owner.item else { return }
				
				BooksRepository.shared.save(item: item)
			}
			.disposed(by: self.disposeBag)
	}
}

// MARK: - Layout

private extension DetailSaveLibraryCell {
	func defineFlexContainer() {
		self.contentView.flex
			.paddingHorizontal(60)
			.paddingVertical(15)
			.define {
				$0.addItem(self.saveButton).grow(1)
			}
	}
	
	func layoutFlexContainer() {
		self.contentView.flex.layout()
	}
}
