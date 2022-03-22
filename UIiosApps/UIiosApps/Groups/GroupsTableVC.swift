//
//  GroupsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

class GroupsTableVC: UITableViewController {
	
	@IBOutlet weak var searchBar: UISearchBar!
	
	private var groups: [Group] = []
	private var filteredData: [Group]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGroups()
		searchBar.delegate = self
		filteredData = groups
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredData.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
		cell.configureCell(group: filteredData[indexPath.row])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		// Если была нажата кнопка «Удалить»
		if editingStyle == .delete {
			filteredData.remove(at: indexPath.row)
			// И удаляем строку из таблицы
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "addGroupsSeque" {
			guard let dist = segue.destination as? AvailableGroupsTableVC else { return }
			dist.addedGroups = groups
		}
	}
	
	private func getGroups() {

//		VCAPIService.shared.loadGroups(){ [weak self] data in
//			do {
//				let groupsResponse = try JSONDecoder().decode(GroupResponse.self, from: data as! Data)
//				self?.groups = groupsResponse.groups
//				self?.filteredData = groupsResponse.groups
//				DispatchQueue.main.sync {
//					self?.tableView.reloadData()
//				}
//			} catch {
//				debugPrint(error.localizedDescription)
//			}
//		}

	}
	
	@IBAction func addGroups(segue: UIStoryboardSegue) {
		// Проверяем идентификатор, чтобы убедиться, что это нужный переход
		if segue.identifier == "addGroups" {
			// Получаем ссылку на контроллер, с которого осуществлен переход
			let availableGroupsTableVC = segue.source as! AvailableGroupsTableVC
			// Получаем индекс выделенной ячейки
			if let indexPath = availableGroupsTableVC.tableView.indexPathForSelectedRow {
				let group = availableGroupsTableVC.groups[indexPath.row]
				groups.append(group)
				tableView.reloadData()
			}
		}
	}
	
}

// MARK: - SearchBar
extension GroupsTableVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		VCAPIService.shared.searchGroups(searchString: searchText) { data in
			print("Поиск грууппы----------------------")
			print(data)
		}
		
		filteredData = searchText.isEmpty ? groups : groups.filter({ group in
			group.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
		})
		tableView.reloadData()
	}
	
}
