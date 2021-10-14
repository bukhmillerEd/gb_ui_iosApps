//
//  GroupsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

class GroupsTableVC: UITableViewController {
	
	private var groups: [Group] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGroups()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
		cell.configureCell(group: groups[indexPath.row])
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		// Если была нажата кнопка «Удалить»
		if editingStyle == .delete {
			groups.remove(at: indexPath.row)
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
		groups.append(Group(name: "Geekbrains", image: UIImage(named: "gb")))
		groups.append(Group(name: "Skillbox", image: UIImage(named: "sb")))
		groups.append(Group(name: "Swiftbook", image: UIImage(named: "swiftbook")))
		groups.append(Group(name: "Swift", image: UIImage(named: "swift")))
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
