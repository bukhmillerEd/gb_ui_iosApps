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
		avatarImg.image = group.image
		nameLbl.text = group.name
	}
	
}
