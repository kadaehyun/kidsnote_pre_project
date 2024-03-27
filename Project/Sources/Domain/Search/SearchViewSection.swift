//
//  SearchViewSection.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import RxDataSources

struct SearchViewSection {
	enum Identity: Hashable {
		case googleplay
	}

	var identity: Identity
	var items: [Item]
}

extension SearchViewSection {
	enum Item: Hashable {
		case googleplay(BooksItem)
	}
}

extension SearchViewSection: AnimatableSectionModelType {
	init(original: SearchViewSection, items: [Item]) {
		self = original
		self.items = items
	}
}

extension SearchViewSection.Item: IdentifiableType {
	var identity: Int {
		self.hashValue
	}
}
