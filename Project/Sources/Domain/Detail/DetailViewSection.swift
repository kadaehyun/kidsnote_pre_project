//
//  DetailViewSection.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import RxDataSources

struct DetailViewSection {
	enum Identity: Hashable {
		case volumeInfo
		case saveLibrary
		case eBookInfo
		case publishedDate
	}

	var identity: Identity
	var items: [Item]
}

extension DetailViewSection {
	enum Item: Hashable {
		case volumeInfo(VolumeInfo)
		case saveLibrary(BooksItem)
		case eBookInfo(VolumeInfo)
		case publishedDate(VolumeInfo)
	}
}

extension DetailViewSection: AnimatableSectionModelType {
	init(original: DetailViewSection, items: [Item]) {
		self = original
		self.items = items
	}
}

extension DetailViewSection.Item: IdentifiableType {
	var identity: Int {
		self.hashValue
	}
}
