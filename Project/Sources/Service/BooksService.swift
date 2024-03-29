//
//  BooksService.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import Foundation
import RxSwift

enum ApiError: Error {
	case badUrl
	case invalidResponse
	case failed(Int)
	case invalidData
}

final class BooksService {
	func fetchBooks(keyword: String, startIndex: Int) -> Observable<BooksModel> {
		return Observable.create() { observer in
			var components = URLComponents(string: "https://www.googleapis.com/books/v1/volumes")
			components?.queryItems = [
				URLQueryItem(name: "q", value: keyword),
				URLQueryItem(name: "startIndex", value: String(startIndex)),
				URLQueryItem(name: "maxResults", value: "40")
			]
			
			guard let url = components?.url else {
				observer.onError(ApiError.badUrl)
				return Disposables.create()
			}
			
			let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
				if let error = error {
					observer.onError(error)
					return
				}
				
				guard let httpResponse = response as? HTTPURLResponse else {
					observer.onError(ApiError.invalidResponse)
					return
				}
				
				guard (200...299).contains(httpResponse.statusCode) else {
					observer.onError(ApiError.failed(httpResponse.statusCode))
					return
				}

				guard let data = data else {
					observer.onError(ApiError.invalidData)
					return
				}
				
				do {
					let decoder = JSONDecoder()
					let result = try decoder.decode(BooksModel.self, from: data)

					observer.onNext(result)
					observer.onCompleted()
				} catch {
					observer.onError(error)
				}
			}
			
			task.resume()
			
			return Disposables.create() {
				task.cancel()
			}
		}
	}
}
