import UIKit
import Alamofire

final class FriendsLoaderService {
	
	func getFriends(completion: @escaping ( ([String:[User]]) -> Void) ) {
		loadFriends() { users in
			var friends: [String:[User]] = [:]
			for user in users {
				// Получаем первый символ
				var char: String
				if let firstChar = user.name.first {
					char = String(firstChar)
					// добавляем в словарь
					if friends[char] != nil {
						friends[char]!.append(user)
					} else {
						friends[char] = [user]
					}
				}
			}
			DispatchQueue.main.async {
				completion(friends)
			}
		}
	}
	
	private func loadFriends(complitionHandler: @escaping([User]) -> Void) {
		
//		VCAPIService.shared.loadFreinds() { data in
//			do {
//				let freinds = try JSONDecoder().decode(UserContainer.self, from: data as! Data)
//				complitionHandler(freinds.users)
//			} catch {
//				debugPrint(error.localizedDescription)
//			}
//		}
	}
	
}
