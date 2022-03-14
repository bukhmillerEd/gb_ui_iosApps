//
//  PhotoResponse.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.03.2022.
//

import Foundation
import UIKit

struct PhotoResponse: Decodable {
	let photos: [Photo]
	
	enum CodingKeys: String, CodingKey {
		case response
		
		enum PhotosKeys: String, CodingKey {
			case photos = "items"
		}
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let response = try container.nestedContainer(keyedBy: CodingKeys.PhotosKeys.self, forKey: .response)
		self.photos = try response.decode([Photo].self, forKey: .photos)
	}
}

struct Photo: Decodable {
	let sizes: [Size]
	
	struct Size: Decodable {
		var photo: UIImage?
		
		enum CodingKeys: String, CodingKey {
			case url
		}
		
		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			let url = try container.decode(String.self, forKey: .url)
			if let url = URL(string: url) {
				self.photo = UIImage(data: try Data(contentsOf: url))
			}
			
		}
	}
}

