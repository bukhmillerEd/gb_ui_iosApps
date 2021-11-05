import UIKit

final class FriendsLoaderService {
	
	private var friends: [String:[User]] = [:]
	
	func getFriends() -> [String:[User]] {
		let users = loadFriends()
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
		return friends
	}
	
	func getFirstCharOfNmaeSorted() -> [String] {
		return Array(friends.keys).sorted(by: <)
	}
	
	private func loadFriends() -> [User] {
		let defaultImg = UIImage(named: "DefaultAvatar")
		return [
		  User(name: "Vladimir Putin", avatar: UIImage(named: "Putin") ?? defaultImg),
			User(name: "Donald Trump", avatar: UIImage(named: "Trump") ?? defaultImg),
			User(name: "Elon Mask", avatar: UIImage(named: "Mask") ?? defaultImg),
			User(name: "Joe Biden", avatar: UIImage(named: "Biden") ?? defaultImg),
			User(name: "d", avatar: UIImage(named: "1") ?? defaultImg),
			User(name: "Andrey", avatar: UIImage(named: "1") ?? defaultImg),
			User(name: "Alex", avatar: UIImage(named: "1") ?? defaultImg),
			User(name: "Artem", avatar: UIImage(named: "1") ?? defaultImg),
			User(name: "Irina", avatar: UIImage(named: "1") ?? defaultImg)
		]
	}
		
}
