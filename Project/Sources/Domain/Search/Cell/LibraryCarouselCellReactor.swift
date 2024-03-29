//
//  LibraryCarouselCellReactor.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/30/24.
//

import ReactorKit
import RxSwift

final class LibraryCarouselCellReactor: Reactor {
	
	// MARK: - Reactor

	enum Action {
		case refresh
	}
	
	enum Mutation {
		case updateSections
	}
	
	struct State {
		fileprivate var items: [BooksItem]
		var sections: [LibraryCarouselCellSection]
	}
	
	// MARK: - Properties

	let initialState: State
	
	// MARK: - Initialize
	
	init(items: [BooksItem]) {
		self.initialState = State(
			items: items,
			sections: []
		)
	}
	
	// MARK: - Action -> Mutation

	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
		case .refresh:
			return Observable.just(.updateSections)
		}
	}
	
	// MARK: - Mutation -> State

	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state
		
		switch mutation {
		case .updateSections:
			defer { newState.sections.removeDuplicates() }
			
			newState.sections = [
				Self.librarySection(state: newState)
			]
		}
		
		return newState
	}
}

// MARK: Section Assemble

extension LibraryCarouselCellReactor {
	static func librarySection(state: State) -> LibraryCarouselCellSection {
		let items = state.items.compactMap { item -> LibraryCarouselCellSection.Item in
			return .library(item)
		}
		
		return .init(identity: .library, items: items)
	}
}
