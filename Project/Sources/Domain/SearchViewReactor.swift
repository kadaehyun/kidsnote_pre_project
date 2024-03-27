//
//  SearchViewReactor.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import ReactorKit
import RxSwift

final class SearchViewReactor: Reactor {
	
	// MARK: - Reactor

	enum Action {
		case search(String?)
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
		switch action {
		case let .search(text):
			guard let text, text.isEmpty == false else { return .empty() }
			
			return self.fetchBooks(text: text)
		}
	}
	
	// MARK: - Mutation -> State

	func reduce(state: State, mutation: Mutation) -> State {
		state
	}
	
	private func fetchBooks(text: String) -> Observable<Mutation> {
		.empty()
	}
}
