//
//  FreindsCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import UIKit

class FreindsCell: UITableViewCell {
	
	@IBOutlet weak var nameLbl: UILabel!
	@IBOutlet weak var avatar: AvatarCustomView!
	
	func configureCell(user: User) {
		avatar.img = user.avatar
		nameLbl.text = user.name
	}
	
}
