//
//  DetailViewReactor.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import ReactorKit
import RxSwift

final class DetailViewReactor: Reactor {
	
	// MARK: - Reactor

	enum Action {
	}
	
	enum Mutation {
	}
	
	struct State {
		var item: BooksItem
		var sections: [DetailViewSection]
	}
	
	// MARK: - Properties
	
	let initialState: State
	
	// MARK: - Initialize
	
	init(item: BooksItem) {
		self.initialState = State(
			item: item,
			sections: [
				Self.volumeInfoSection(item: item),
				Self.saveLibrarySection(item: item),
				Self.eBookInfoSection(item: item),
				Self.publishedDateSection(item: item)
			].compactMap { $0 }
		)
	}
	
	// MARK: - Action -> Mutation

	func mutate(action: Action) -> Observable<Mutation> {
		.empty()
	}
	
	// MARK: - Mutation -> State

	func reduce(state: State, mutation: Mutation) -> State {
		state
	}
}

// MARK: Section Assemble

extension DetailViewReactor {
	static func volumeInfoSection(item: BooksItem) -> DetailViewSection? {
		guard let volumeInfo = item.volumeInfo else { return nil }
		
		return .init(identity: .volumeInfo, items: [.volumeInfo(volumeInfo)])
	}
	
	static func saveLibrarySection(item: BooksItem) -> DetailViewSection? {
		return .init(identity: .saveLibrary, items: [.saveLibrary(item)])
	}
	
	static func eBookInfoSection(item: BooksItem) -> DetailViewSection? {
		guard let volumeInfo = item.volumeInfo else { return nil }
		
		return .init(identity: .eBookInfo, items: [.eBookInfo(volumeInfo)])
	}
	
	static func publishedDateSection(item: BooksItem) -> DetailViewSection? {
		guard let volumeInfo = item.volumeInfo else { return nil }
		
		return .init(identity: .publishedDate, items: [.publishedDate(volumeInfo)])
	}
}
