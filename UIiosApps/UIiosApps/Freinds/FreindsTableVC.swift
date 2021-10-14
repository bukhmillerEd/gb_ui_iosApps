//
//  FreindsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import UIKit

class FreindsTableVC: UITableViewController {
	
	private var users: [User] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getUsers()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "FreindCell", for: indexPath) as! FreindsCell
		cell.configureCell(user: users[indexPath.row])
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
			destination.user = users[indexPath.row]
		}
	}
	
	private func getUsers() {
		let defaultImg = UIImage(named: "DefaultAvatar")
		users.append(User(name: "Vladimir Putin", avatar: UIImage(named: "Putin") ?? defaultImg))
		users.append(User(name: "Donald Trump", avatar: UIImage(named: "Trump") ?? defaultImg))
		users.append(User(name: "Ilon Mask", avatar: UIImage(named: "Mask") ?? defaultImg))
		users.append(User(name: "Joe Biden", avatar: UIImage(named: "Biden") ?? defaultImg))
	}
	
}
