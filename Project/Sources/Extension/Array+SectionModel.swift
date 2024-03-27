//
//  Array+SectionModel.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import RxDataSources

public extension Array where Element: SectionModelType, Element.Item: Hashable {
	private typealias Section = Element
	
	func removingDuplicates() -> [Element] {
		var set = Set<Section.Item>()
		return self.compactMap { section -> Section? in
			let uniqueItems = section.items.filter { set.insert($0).inserted }
			guard !uniqueItems.isEmpty else { return nil }
			return Section(original: section, items: uniqueItems)
		}
	}
	
	mutating func removeDuplicates() {
		self = self.removingDuplicates()
	}
}
