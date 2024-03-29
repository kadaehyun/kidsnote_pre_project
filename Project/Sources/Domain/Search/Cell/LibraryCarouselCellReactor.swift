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
	}
	
	// MARK: - Properties

	let initialState: State
	
	// MARK: - Initialize
	
	init() {
		self.initialState = State(
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
