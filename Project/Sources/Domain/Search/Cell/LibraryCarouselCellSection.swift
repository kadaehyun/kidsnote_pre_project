//
//  LibraryCarouselCellSection.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/30/24.
//

import RxDataSources

struct LibraryCarouselCellSection {
	enum Identity: Hashable {
		case library
	}

	var identity: Identity
	var items: [Item]
}

extension LibraryCarouselCellSection {
	enum Item: Hashable {
		case library(BooksItem)
	}
}

extension LibraryCarouselCellSection: AnimatableSectionModelType {
	init(original: LibraryCarouselCellSection, items: [Item]) {
		self = original
		self.items = items
	}
}

extension LibraryCarouselCellSection.Item: IdentifiableType {
	var identity: Int {
		self.hashValue
	}
}
