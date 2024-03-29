//
//  BooksEntity.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import RealmSwift

class BooksEntity: Object {
	@Persisted(primaryKey: true) var _id: ObjectId
	@Persisted var ownerId: String = ""
	@Persisted var title: String = ""
	@Persisted var author: String = ""
	@Persisted var publisher: String = ""
	@Persisted var publishedDate: String = ""
	@Persisted var descriptionData: String = ""
	@Persisted var pageCount: Int = 0
	@Persisted var printType: String = ""
	@Persisted var averageRating: Int = 0
	@Persisted var smallThumbnail: String = ""
	@Persisted var thumbnail: String = ""
	@Persisted var infoLink: String = ""
	
	public required convenience init(model: BooksItem) {
		self.init()
		self.ownerId = model.id ?? ""
		self.title = model.volumeInfo?.title ?? ""
		self.author = model.volumeInfo?.authors?.first ?? ""
		self.publisher = model.volumeInfo?.publisher ?? ""
		self.publishedDate = model.volumeInfo?.publishedDate ?? ""
		self.descriptionData = model.volumeInfo?.description ?? ""
		self.pageCount = model.volumeInfo?.pageCount ?? 0
		self.printType = model.volumeInfo?.printType ?? ""
		self.averageRating = model.volumeInfo?.averageRating ?? 0
		self.smallThumbnail = model.volumeInfo?.imageLinks?.smallThumbnail ?? ""
		self.thumbnail = model.volumeInfo?.imageLinks?.thumbnail ?? ""
		self.infoLink = model.volumeInfo?.infoLink ?? ""
	}
}

extension BooksEntity {
	var model: BooksItem {
		BooksItem(
			kind: nil,
			id: self.ownerId,
			etag: nil,
			selfLink: nil,
			volumeInfo: VolumeInfo(
				title: self.title,
				authors: [self.author],
				publisher: self.publisher,
				publishedDate: self.publishedDate,
				description: self.descriptionData,
				readingModes: nil,
				pageCount: self.pageCount,
				printType: self.printType,
				categories: nil,
				averageRating: self.averageRating > 0 ? self.averageRating : nil,
				ratingsCount: nil,
				maturityRating: nil,
				allowAnonLogging: nil,
				contentVersion: nil,
				panelizationSummary: nil,
				imageLinks: VolumeInfo.ImageLinks(
					smallThumbnail: self.smallThumbnail,
					thumbnail: self.thumbnail
				),
				language: nil,
				previewLink: nil,
				infoLink: self.infoLink,
				icanonicalVolumeLinkd: nil
			),
			saleInfo: nil,
			accessInfo: nil,
			searchInfo: nil
		)
	}
}
