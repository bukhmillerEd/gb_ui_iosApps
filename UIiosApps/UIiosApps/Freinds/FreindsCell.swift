//
//  FreindsCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 13.10.2021.
//

import UIKit

class FreindsCell: UITableViewCell {
	
	@IBOutlet weak var avatarImg: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	
	func configureCell(user: User) {
		avatarImg.image = user.avatar
		nameLbl.text = user.name
	}
}
