//
//  BooksRepository.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import Realm
import RealmSwift

class BooksRepository {
	static let shared = BooksRepository()
	
	let realm: Realm = {
		return try! Realm()
	}()
		
	func save(item: BooksItem) {
		try? self.realm.write {
			let model = BooksEntity(model: item)
			
			self.realm.add(model, update: .modified)
		}
	}
	
	func fetchItem(text: String) -> [BooksItem] {
		let predicate = NSPredicate(format: "title contains[c] %@", text)
		let result = self.realm.objects(BooksEntity.self).filter(predicate)
		
		return result.compactMap { $0.model }
	}
}

