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
		case nextPage
		case textChanged(String)
	}
	
	enum Mutation {
		case setLoading(Bool)
		case setKeyword(String)
		case setItems([BooksItem])
		case appendItems([BooksItem])
		case setLibraryItems([BooksItem])
		case setLibrarySearchItems([BooksItem])
		case setTotalItemCount(Int)
		case updateSections
	}
	
	struct State {
		var isLoading: Bool
		fileprivate var keyword: String
		fileprivate var items: [BooksItem]
		fileprivate var libraryItems: [BooksItem]
		fileprivate var librarySearchItems: [BooksItem]
		fileprivate var totalItemCount: Int
		var sections: [SearchViewSection]
	}
	
	// MARK: - Properties
	
	let initialState: State
	
	// MARK: - Initialize
	
	init() {
		self.initialState = State(
			isLoading: false,
			keyword: "",
			items: [],
			libraryItems: [],
			librarySearchItems: [],
			totalItemCount: 0,
			sections: []
		)
	}
	
	// MARK: - Action -> Mutation

	func mutate(action: Action) -> Observable<Mutation> {
		switch action {
		case let .search(keyword):
			guard let keyword, keyword.isEmpty == false else { return .empty() }
			guard self.currentState.isLoading == false else { return .empty() }
			
			return Observable.concat([
				Observable.just(Mutation.setLoading(true)),
				Observable.just(Mutation.setLibraryItems([])),
				self.fetchLibrarySearchBooks(keyword: keyword),
				Observable.just(Mutation.updateSections),
				self.fetchBooks(keyword: keyword),
				Observable.just(Mutation.setLoading(false)),
				Observable.just(Mutation.updateSections)
			])
		case .nextPage:
			guard self.currentState.items.count < self.currentState.totalItemCount else { return .empty() }
			guard self.currentState.isLoading == false else { return .empty() }
			
			return Observable.concat([
				Observable.just(Mutation.setLoading(true)),
				self.fetchBooks(),
				Observable.just(Mutation.setLoading(false)),
				Observable.just(Mutation.updateSections)
			])
		case let .textChanged(text):
			return Observable.concat([
				self.fetchLibraryBooks(text: text),
				Observable.just(Mutation.updateSections)
			])
		}
	}
	
	// MARK: - Mutation -> State

	func reduce(state: State, mutation: Mutation) -> State {
		var newState = state

		switch mutation {
		case let .setLoading(isLoading):
			newState.isLoading = isLoading
			
		case let .setKeyword(keyword):
			newState.keyword = keyword
			
		case let .setItems(items):
			newState.items = items
		
		case let .appendItems(items):
			var originItems = newState.items
			
			originItems += items
			
			newState.items = originItems
			
		case let .setLibraryItems(items):
			newState.libraryItems = items
			
		case let .setLibrarySearchItems(items):
			newState.librarySearchItems = items
			
		case let .setTotalItemCount(count):
			newState.totalItemCount = count
			
		case .updateSections:
			defer { newState.sections.removeDuplicates() }
			
			newState.sections = self.assembleSections(state: newState)
		}
		
		return newState
	}
	
	// MARK: - Private
	
	private func fetchBooks(keyword: String? = nil) -> Observable<Mutation> {
		if let keyword, keyword.isEmpty == false {
			BooksService().fetchBooks(keyword: keyword, startIndex: 0)
				.asObservable()
				.flatMap { response -> Observable<Mutation> in
					guard let items = response.items, let totalCount = response.totalItems else { return .empty() }
					
					return Observable.concat([
						Observable.just(Mutation.setKeyword(keyword)),
						Observable.just(Mutation.setItems(items)),
						Observable.just(Mutation.setTotalItemCount(totalCount))
					])
				}.catch { _ in .empty() }
		} else {
			BooksService().fetchBooks(keyword: self.currentState.keyword, startIndex: self.currentState.items.count - 1)
				.asObservable()
				.flatMap { response -> Observable<Mutation> in
					guard let items = response.items else { return .empty() }
					
					return Observable.just(Mutation.appendItems(items))
				}.catch { _ in .empty() }
		}
	}
	
	private func fetchLibrarySearchBooks(keyword: String) -> Observable<Mutation> {
		let libraryItems = BooksRepository.shared.fetchItem(text: keyword)
		
		return Observable.just(Mutation.setLibrarySearchItems(libraryItems))
	}
	
	private func fetchLibraryBooks(text: String) -> Observable<Mutation> {
		let libraryItems = BooksRepository.shared.fetchItem(text: text)
		
		return Observable.concat([
			Observable.just(Mutation.setKeyword("")),
			Observable.just(Mutation.setItems([])),
			Observable.just(Mutation.setLibrarySearchItems([])),
			Observable.just(Mutation.setTotalItemCount(0)),
			Observable.just(Mutation.setLibraryItems(libraryItems))
		])
	}
}


// MARK: - Assemble Sections

extension SearchViewReactor {
	private func assembleSections(state: State) -> [SearchViewSection] {
		var assembledSections: [SearchViewSection] = []
		
		if state.libraryItems.count > 0 {
			let items = state.libraryItems.compactMap { item -> SearchViewSection.Item in
				return .library(item)
			}
			
			assembledSections.append(SearchViewSection(identity: .library, items: items))
		}
		
		if state.librarySearchItems.count > 0 {
			assembledSections.append(
				SearchViewSection(
					identity: .librarySearch,
					items: [.librarySearch(state.librarySearchItems)]
				)
			)
		}
		
		if state.items.count > 0 {
			let items = state.items.compactMap { item -> SearchViewSection.Item in
				return .googleplay(item)
			}
			
			assembledSections.append(SearchViewSection(identity: .googleplay, items: items))
		}

		return assembledSections
	}
}
