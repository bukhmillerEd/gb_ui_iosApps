//
//  NewsLikeControl.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 25.10.2021.
//

import Foundation
import UIKit

class NewsLikeControl: UIControl {
	@IBOutlet weak var imageLikeImg: UIImageView!
	@IBOutlet weak var countLokeLbl: UILabel!
	
	private var likesCount = 0
	
	lazy var recognizer: UITapGestureRecognizer = {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(click))
		gesture.numberOfTapsRequired = 1
		gesture.numberOfTouchesRequired = 1
		return gesture
	}()
	
	@objc func click() {
		if likesCount == 0 {
			imageLikeImg.image = UIImage(systemName: "heart.fill")
			imageLikeImg.tintColor = .red
			countLokeLbl.textColor = .red
			likesCount += 1
		} else {
			likesCount -= 1
			imageLikeImg.image = UIImage(systemName: "heart")
			imageLikeImg.tintColor = .black
			countLokeLbl.textColor = .black
		}
		countLokeLbl.text = String(likesCount)
	}
	
	required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
			addGestureRecognizer(recognizer)
	}
}
