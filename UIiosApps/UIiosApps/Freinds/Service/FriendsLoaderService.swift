import UIKit
import Alamofire
import RealmSwift

final class FriendsLoaderService {
	
	func getFriends() {
		
		loadFriends { users in
			// Загружаем данные и сохраняем их в Realm
			do {
				//let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
				//let realm = try Realm(configuration: config)
				let realm = try Realm()
				print(realm.configuration.fileURL)
				realm.beginWrite()
				realm.add(users, update: .modified)
				try realm.commitWrite()
			} catch {
				print("ERROR", error.localizedDescription)
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
