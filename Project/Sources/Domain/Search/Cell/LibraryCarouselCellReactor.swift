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
	}
	
	enum Mutation {
	}
	
	struct State {
		fileprivate var items: [BooksItem]
	}
	
	// MARK: - Properties

	let initialState: State
	
	// MARK: - Initialize
	
	init(items: [BooksItem]) {
		self.initialState = State(
			items: items
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
