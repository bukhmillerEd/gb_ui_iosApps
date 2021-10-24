//
//  FreindCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

class FreindCell: UICollectionViewCell {
	@IBOutlet weak var avatarImg: UIImageView!
	@IBOutlet weak var counLike: UILabel!
	
	private var liked = false

	func configureCell(user: User){
		avatarImg.image = user.avatar
	}
	
	@IBAction func likePressed(_ sender: UIButton) {
		let numCounLike = Int(counLike.text!)!
		if liked {
			sender.setImage(UIImage(systemName: "heart"), for: .normal)
			sender.tintColor = .black
			counLike.text = String(numCounLike - 1)
			counLike.textColor = .black
			liked = false
		} else {
			sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
			sender.tintColor = .red
			counLike.text = String(numCounLike + 1)
			counLike.textColor = .red
			liked = true
		}
		
		
	}
	
}
