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

struct BooksItem: Decodable {
	let kind: String?
	let id: String?
	let etag: String?
	let selfLink: String?
	let volumeInfo: VolumeInfo?
	let saleInfo: SaleInfo?
	let accessInfo: AccessInfo?
	let searchInfo: SearchInfo?
}

struct VolumeInfo: Decodable {
	let title: String?
	let authors: [String]?
	let publisher: String?
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
	
	struct ReadingModes: Decodable {
		let text: Bool?
		let image: Bool?
	}
	
	struct PanelizationSummary: Decodable {
		let containsEpubBubbles: Bool?
		let containsImageBubbles: Bool?
	}
	
	struct ImageLinks: Decodable {
		let smallThumbnail: String?
		let thumbnail: String?
	}
}

struct SaleInfo: Decodable {
	let country: String?
	let saleability: String?
	let isEbook: Bool?
	let listPrice: ListPrice?
	let retailPrice: RetailPrice?
	let buyLink: String?
	let offers: [Offers]?
	
	struct ListPrice: Decodable {
		let amount: Int?
		let currencyCode: String?
	}
	
	struct RetailPrice: Decodable {
		let amount: Int?
		let currencyCode: String?
	}
	
	struct Offers: Decodable {
		let finskyOfferType: Int?
		let listPrice: ListPrice?
		let retailPrice: RetailPrice?
		
		struct ListPrice: Decodable {
			let amountInMicros: Int?
			let currencyCode: String?
		}
		
		struct RetailPrice: Decodable {
			let amountInMicros: Int?
			let currencyCode: String?
		}
	}
}

struct AccessInfo: Decodable {
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
	
	struct Epub: Decodable {
		let isAvailable: Bool?
	}
	
	struct Pdf: Decodable {
		let isAvailable: Bool?
	}
}

struct SearchInfo: Decodable {
	let textSnippet: String?
}
