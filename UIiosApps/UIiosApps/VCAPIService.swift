//
//  VCAPIService.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 27.02.2022.
//

import Foundation
import Alamofire

extension Request {
	enum Scheme: String {
		case http, https
	}
	
	enum Path: String {
		case freinds = "/method/friends.get"
		case photos = "/method/photos.getAll"
		case groups = "/method/groups.get"
		case groupsSearch = "/method/groups.search"
		case photosById = "/method/photos.getById"
	}
	
	enum Host: String {
		case main = "api.vk.com"
	}
}

struct Request {
	let host: Host = .main
	let scheme: Scheme = .https
	var params: [String: String] = [
		"access_token" : Session.shared.token ?? "",
		"v":"5.131"
	]
	let path: Path
	
	var url: URL? {
		var components = URLComponents()
		components.scheme = scheme.rawValue
		components.host = host.rawValue
		components.path = path.rawValue
		components.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
		
		return components.url
	}
}

class VCAPIService {
	static let shared = VCAPIService()
	
	private func load(request: Request, complition: @escaping (Any?) -> Void) {
		guard let url = request.url else {
			return
		}
		let task = URLSession.shared.dataTask(with: url) { data, responce, error in
			if let error = error {
				print(error.localizedDescription)
				return
			}
			guard let data = data else {
				return
			}
			complition(data)
		}
		task.resume()
	}
	
	func loadFreinds(complition: @escaping (Any?) -> Void) {
		var req = Request(path: .freinds)
		req.params["fields"] = "photo_100"
		load(request: req, complition: complition )
	}
	
	func loadPhotos(ownerId: String, complition: @escaping (Any?) -> Void) {
		var req = Request(path: .photos)
		req.params["owner_id"] = ownerId
		load(request: req, complition: complition )
	}
	
	func loadGroups(complition: @escaping (Any?) -> Void) {
		var req = Request(path: .groups)
		req.params["fields"] = "photo_100"
		req.params["extended"] = "1"
		load(request: req, complition: complition )
	}
	
	func searchGroups(searchString: String, complition: @escaping (Any?) -> Void) {
		var req = Request(path: .groupsSearch)
		req.params["q"] = searchString
		load(request: req, complition: complition )
	}
	
	func loadPhotos(id: String, complition: @escaping (Any?) -> Void) {
		var req = Request(path: .photosById)
		req.params["photos"] = id
		load(request: req, complition: complition)
	}
}
