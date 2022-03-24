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
		if let urlAvatar = URL(string: user.urlAvatar) {
			do {
				avatar.img = UIImage(data: try Data(contentsOf: urlAvatar))
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
		nameLbl.text = user.name
	}
	
	override func prepareForReuse() {
		avatar.img = nil
	}
	
}
