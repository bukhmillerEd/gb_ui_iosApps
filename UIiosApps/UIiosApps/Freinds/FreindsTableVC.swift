//
//  FreindsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import UIKit

class FreindsTableVC: UITableViewController {
	
	private var users: [String:[User]] = [:]
	private var firstCharOfNmaeSorted: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getUsers()
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
		guard let arrUsers = users[key] else { return cell }
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
			guard let arrUsers = users[key] else { return }
			destination.user = arrUsers[indexPath.row]
		}
	}
	
	private func getUsers() {
		FriendsLoaderService().getFriends(completion: {[weak self] users in
			self?.users = users
			self?.firstCharOfNmaeSorted = Array(users.keys).sorted(by: <)
			self?.tableView.reloadData()
		})
	}
	
}
