import UIKit
import Alamofire
import RealmSwift

final class FriendsLoaderService {
	
	func getFriends(completion: @escaping ( ([String:[User]]) -> Void) ) {
		
		loadFriends { users in
			// Загружаем данные и сохраняем их в Realm
			do {
				let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
				let realm = try Realm(configuration: config)
				print(realm.configuration.fileURL)
				realm.beginWrite()
				realm.add(users, update: .modified)
				try realm.commitWrite()
			} catch {
				print("ERROR", error.localizedDescription)
			}
			
			
			DispatchQueue.main.async() {
				do {
					// читаем данные из Realm и сортируем
					let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
					let realm = try Realm(configuration: config)
					
					let friends = Array(realm.objects(User.self))
					var sortFriends: [String:[User]] = [:]
					for user in friends {
						// Получаем первый символ
						var char: String
						if let firstChar = user.name.first {
							char = String(firstChar)
							// добавляем в словарь
							if sortFriends[char] != nil {
								sortFriends[char]!.append(user)
							} else {
								sortFriends[char] = [user]
							}
						}
					}
					completion(sortFriends)
				} catch {
					print(error.localizedDescription)
				}
				
				
			}
			
		}
	}
	
	private func loadFriends(complitionHandler: @escaping([User]) -> Void) {
		VCAPIService.shared.loadFreinds() { data in
			do {
				let freinds = try JSONDecoder().decode(UserContainer.self, from: data as! Data)
				complitionHandler(freinds.users)
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
	}
	
}
