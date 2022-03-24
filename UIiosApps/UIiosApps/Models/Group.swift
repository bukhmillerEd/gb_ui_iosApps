//
//  Group.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import Foundation
import UIKit

import RealmSwift

//struct Group: Decodable {
class Group: Object, Decodable {
	@objc dynamic var name: String = ""
	@objc dynamic var urlImage: String = ""

	//var image: UIImage? = nil
	
	enum CodingKeys: String, CodingKey {
		case name
		case photo = "photo_100"
	}
	
	override init() {
		super.init()
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.name = try container.decode(String.self, forKey: .name)
		
		let url = try container.decode(String.self, forKey: .photo)
		self.urlImage = url
//		if let url = URL(string: url) {
//			self.image = UIImage(data: try Data(contentsOf: url))
//		}
	}
	
	override class func primaryKey() -> String? {
		"name"
	}
}


class GroupResponse: Decodable {
	var groups: [Group]
	
	enum CodingKeys: String, CodingKey {
		case response
		
		enum GroupKeys: String, CodingKey {
			case group = "items"
		}
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let response = try container.nestedContainer(keyedBy: CodingKeys.GroupKeys.self, forKey: .response)
		self.groups = try response.decode([Group].self, forKey: .group)
	}
}

