//
//  GroupsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit
import RealmSwift

class GroupsTableVC: UITableViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	
	var token: NotificationToken?
	var groups: Results<Group>?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGroups()
		searchBar.delegate = self
		getGroupsFromRealm()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
		if let group = groups?[indexPath.row]  {
			cell.configureCell(group: group)
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		// Если была нажата кнопка «Удалить»
		if editingStyle == .delete {
			guard let realm = try? Realm(), let group = groups?[indexPath.row] else { return }
			do {
				realm.beginWrite()
				realm.delete(group)
				try realm.commitWrite()
			} catch {
				debugPrint(error)
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "addGroupsSeque" {
			guard let dist = segue.destination as? AvailableGroupsTableVC else { return }
			//dist.addedGroups = groups
		}
	}
	
	private func getGroupsFromRealm() {
		guard let realm = try? Realm() else { return }
		groups = realm.objects(Group.self)
		token = groups?.observe(){ [weak self] (changes: RealmCollectionChange) in
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
	}
	
	private func getGroups() {
		
		VCAPIService.shared.loadGroups(){ [weak self] data in
			do {
				let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data as! Data)
				let groups = groupsResponse.groups
				
				// Сохранение групп в Realm
				do {
					let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
					let realm = try Realm(configuration: config)
					print(realm.configuration.fileURL)
					realm.beginWrite()
					realm.add(groups, update: .modified)
					try realm.commitWrite()
				} catch {
					debugPrint(error.localizedDescription)
				}
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
		
	}
	
	@IBAction func addGroups(segue: UIStoryboardSegue) {
//		// Проверяем идентификатор, чтобы убедиться, что это нужный переход
//		if segue.identifier == "addGroups" {
//			// Получаем ссылку на контроллер, с которого осуществлен переход
//			let availableGroupsTableVC = segue.source as! AvailableGroupsTableVC
//			// Получаем индекс выделенной ячейки
//			if let indexPath = availableGroupsTableVC.tableView.indexPathForSelectedRow {
//				let group = availableGroupsTableVC.groups[indexPath.row]
//				groups.append(group)
//				tableView.reloadData()
//			}
//		}
	}
	
}

// MARK: - SearchBar
extension GroupsTableVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let realm = try? Realm() else { return }
		if searchText.isEmpty{
			groups = realm.objects(Group.self)
		} else {
			groups = realm.objects(Group.self).filter("name BEGINSWITH[c] '\(searchText)'")
		}
		tableView.reloadData()
	}
	
}

