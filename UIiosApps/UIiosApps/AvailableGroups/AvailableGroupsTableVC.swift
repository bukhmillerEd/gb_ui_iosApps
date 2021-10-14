//
//  AvailableGroupsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit
import Foundation

class AvailableGroupsTableVC: UITableViewController {
	
	var groups: [Group] = []
	var addedGroups: [Group] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getGroups()
	}
	
	// MARK: - Table view data source
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groups.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupsCell", for: indexPath) as! AvailableGroupsCell
		cell.configureCell(group: groups[indexPath.row])
		return cell
	}

	private func getGroups() {
		add(Group(name: "Udemy", image: UIImage(named: "udemy")))
		add(Group(name: "Специалист", image: UIImage(named: "spec")))
		add(Group(name: "Coursera", image: UIImage(named: "coursera")))
	}
	
	private func add(_ group: Group) {
		if !addedGroups.contains(where: {$0.name == group.name}){
			groups.append(group)
		}
	}

}
