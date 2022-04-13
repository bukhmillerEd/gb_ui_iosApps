//
//  FreindsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import UIKit
import RealmSwift

class FreindsTableVC: UITableViewController {
	
	private var users: [String:[User]] = [:] {
		didSet {
			firstCharOfNmaeSorted = Array(users.keys).sorted(by: <)
		}
	}
	private var firstCharOfNmaeSorted: [String] = []
	
	var token: NotificationToken?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getUsers()
		getFriendsFromRealm()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users[firstCharOfNmaeSorted[section]]?.count ?? 0
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return firstCharOfNmaeSorted.count
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return firstCharOfNmaeSorted[section]
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FreindCell", for: indexPath) as! FreindsCell
		let key = firstCharOfNmaeSorted[indexPath.section]
		guard let arrUsers = users[key] as? [User] else { return cell }
		cell.configureCell(user: arrUsers[indexPath.row])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// Выбор строки в таблице
		performSegue(withIdentifier: "FeindSegue", sender: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "FeindSegue") {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			guard let destination = segue.destination as? FreindCollectionVC else { return }
			let key = Array(users.keys).sorted(by: <)[indexPath.section]
			guard let arrUsers = users[key] as? [User] else { return }
			destination.user = arrUsers[indexPath.row]
		}
	}
	
	private func getFriendsFromRealm() {
		do {
			// читаем данные из Realm и сортируем
			let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
			let realm = try? Realm(configuration: config)
			print(realm?.configuration.fileURL)
			guard let realm = try? Realm() else { return }
			
			let friends = realm.objects(User.self)
			//var sortFriends: [String:[Results<User>]] = [:]
			for user in friends {
				// Получаем первый символ
				var char: String
				if let firstChar = user.name.first {
					char = String(firstChar)
					// добавляем в словарь
					if users[char] != nil {
						//users[char].append(user)
						users[char]?.append(user)
					} else {
						users[char] = [user]
					}
				}
			}
			
			token = friends.observe() {  [weak self] (changes: RealmCollectionChange) in
				guard let tableView = self?.tableView else { return }
				switch changes {
				case .initial:
					tableView.reloadData()
				case .update(_, let deletions, let insertions, let modifications):
					tableView.beginUpdates()
					tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
					tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
					tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
					tableView.endUpdates()
				case .error(let error):
					fatalError("\(error)")
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	private func getUsers() {
		FriendsLoaderService().getFriends()
	}
	
}
