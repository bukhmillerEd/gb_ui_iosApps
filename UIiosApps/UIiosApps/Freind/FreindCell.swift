//
//  FreindCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

class FreindCell: UICollectionViewCell {
	@IBOutlet weak var avatarImg: UIImageView!
	
	func configureCell(user: User){
		avatarImg.image = user.avatar
	}
	
}
