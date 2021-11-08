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
			User(name: "Vladimir Putin",
					 avatar: UIImage(named: "Putin") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Donald Trump",
					 avatar: UIImage(named: "Trump") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Elon Mask",
					 avatar: UIImage(named: "Mask") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "1")]),
			User(name: "Joe Biden",
					 avatar: UIImage(named: "Biden") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "d",
					 avatar: UIImage(named: "1") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Andrey",
					 avatar: UIImage(named: "1") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Alex",
					 avatar: UIImage(named: "1") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Artem",
					 avatar: UIImage(named: "1") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")]),
			User(name: "Irina",
					 avatar: UIImage(named: "1") ?? defaultImg,
					 fotos: [UIImage(named: "tesla1"),
									 UIImage(named: "Mask"),
									 UIImage(named: "Biden"),
									 UIImage(named: "tesla2")])
		]
	}
	
}
