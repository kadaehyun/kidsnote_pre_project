//
//  BooksModel.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import Foundation

struct BooksModel: Decodable {
	let kind: String?
	let totalItems: Int?
	let items: [BooksItem]?
}

struct BooksItem: Decodable, Hashable {
	let kind: String?
	let id: String?
	let etag: String?
	let selfLink: String?
	let volumeInfo: VolumeInfo?
	let saleInfo: SaleInfo?
	let accessInfo: AccessInfo?
	let searchInfo: SearchInfo?
}

struct VolumeInfo: Decodable, Hashable {
	let title: String?
	let authors: [String]?
	let publisher: String?
	let publishedDate: String?
	let description: String?
	let readingModes: ReadingModes?
	let pageCount: Int?
	let printType: String?
	let categories: [String]?
	let averageRating: Int?
	let ratingsCount: Int?
	let maturityRating: String?
	let allowAnonLogging: Bool?
	let contentVersion: String?
	let panelizationSummary: PanelizationSummary?
	let imageLinks: ImageLinks?
	let language: String?
	let previewLink: String?
	let infoLink: String?
	let icanonicalVolumeLinkd: String?
	
	struct ReadingModes: Decodable, Hashable {
		let text: Bool?
		let image: Bool?
	}
	
	struct PanelizationSummary: Decodable, Hashable {
		let containsEpubBubbles: Bool?
		let containsImageBubbles: Bool?
	}
	
	struct ImageLinks: Decodable, Hashable {
		let smallThumbnail: String?
		let thumbnail: String?
	}
}

struct SaleInfo: Decodable, Hashable {
	let country: String?
	let saleability: String?
	let isEbook: Bool?
	let listPrice: ListPrice?
	let retailPrice: RetailPrice?
	let buyLink: String?
	let offers: [Offers]?
	
	struct ListPrice: Decodable, Hashable {
		let amount: Int?
		let currencyCode: String?
	}
	
	struct RetailPrice: Decodable, Hashable {
		let amount: Int?
		let currencyCode: String?
	}
	
	struct Offers: Decodable, Hashable {
		let finskyOfferType: Int?
		let listPrice: ListPrice?
		let retailPrice: RetailPrice?
		
		struct ListPrice: Decodable, Hashable {
			let amountInMicros: Int?
			let currencyCode: String?
		}
		
		struct RetailPrice: Decodable, Hashable {
			let amountInMicros: Int?
			let currencyCode: String?
		}
	}
}

struct AccessInfo: Decodable, Hashable {
	let country: String?
	let viewability: String?
	let embeddable: Bool?
	let publicDomain: Bool?
	let textToSpeechPermission: String?
	let epub: Epub?
	let pdf: Pdf?
	let webReaderLink: String?
	let accessViewStatus: String?
	let quoteSharingAllowed: Bool?
	
	struct Epub: Decodable, Hashable {
		let isAvailable: Bool?
	}
	
	struct Pdf: Decodable, Hashable {
		let isAvailable: Bool?
	}
}

struct SearchInfo: Decodable, Hashable {
	let textSnippet: String?
}
