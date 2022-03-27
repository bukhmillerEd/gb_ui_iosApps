//
//  GroupsCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

class GroupsCell: UITableViewCell {
	@IBOutlet weak var avatarImg: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	
	func configureCell(group: Group){
		if let url = URL(string: group.urlImage),  let data = try? Data(contentsOf: url) {
			avatarImg.image = UIImage(data: data)
		}
		nameLbl.text = group.name
	}
	
}
