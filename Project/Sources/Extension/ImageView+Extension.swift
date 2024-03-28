//
//  ImageView+Extension.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/28/24.
//

import UIKit

extension UIImageView {
	func imageDownload(url: URL) {
		var request = URLRequest(url: url)
		request.httpMethod = "GET"

		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { return }
			guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { return }
			guard let data = data, error == nil, let image = UIImage(data: data) else { return }
			
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}.resume()
	}
}
