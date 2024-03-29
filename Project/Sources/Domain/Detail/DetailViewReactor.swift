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
		fileprivate var item: BooksItem
	}
	
	// MARK: - Properties
	
	let initialState: State
	
	// MARK: - Initialize
	
	init(item: BooksItem) {
		self.initialState = State(
			item: item
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
