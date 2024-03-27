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
		case setItems([BooksItem])
	}
	
	struct State {
		fileprivate var items: [BooksItem]
	}
	
	// MARK: - Properties
	
	let initialState: State
	
	// MARK: - Initialize
	
	init() {
		self.initialState = State(
			items: []
		)
	}
	
	// MARK: - Action -> Mutation

	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
		case let .search(keyword):
			guard let keyword, keyword.isEmpty == false else { return .empty() }
			
			return self.fetchBooks(keyword: keyword)
		}
	}
	
	// MARK: - Mutation -> State

	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state

		switch mutation {
		case let .setItems(items):
			newState.items = items
		}

		return newState
	}
	
	// MARK: - Private
	
	private func fetchBooks(keyword: String) -> Observable<Mutation> {
		BooksService().fetchBooks(keyword: keyword)
			.asObservable()
			.flatMap { response -> Observable<Mutation> in
				guard let items = response.items else { return .empty() }
				
				return Observable.just(Mutation.setItems(items))
			}.catch { _ in .empty() }
	}
}
