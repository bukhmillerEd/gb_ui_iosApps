//
//  User.swift
//  UIiosApps

//  Created by Эдуард Бухмиллер on 13.10.2021.


import Foundation
import UIKit
import RealmSwift

class UserContainer: Decodable {
	var users: [User]

	enum CodingKeys: String, CodingKey {
		case response

		enum UsersKeys: String, CodingKey {
			case users = "items"
		}
	}

	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let response = try container.nestedContainer(keyedBy: CodingKeys.UsersKeys.self, forKey: .response)
		self.users = try response.decode([User].self, forKey: .users)
	}
}

class User: Object, Decodable {
	@objc dynamic var id: Int = 0
	@objc dynamic var name: String = ""
	@objc dynamic var urlAvatar: String = ""

	//var avatar: UIImage? = nil
	var fotos: [UIImage?] = []
	
	enum CodingKeys: String, CodingKey {
		case firstName = "first_name"
		case lastName = "last_name"
		case avatar = "photo_100"
		case id
	}
	
	override init() {
		super.init()
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.id = try container.decode(Int.self, forKey: .id)
		
		let firstName = try container.decode(String.self, forKey: .firstName)
		let lastName = try container.decode(String.self, forKey: .lastName)
		self.name = firstName + " " + lastName
		
		//let urlAvatar = try container.decode(URL.self, forKey: .avatar)
		//self.avatar = UIImage(data: try Data(contentsOf: urlAvatar))
		let urlAvatar = try container.decode(String.self, forKey: .avatar)
		self.urlAvatar = urlAvatar
	}
	
	override class func primaryKey() -> String? {
		return "id"
	}
	
}

