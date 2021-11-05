//
//  ImageNewsCollectionViewCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 25.10.2021.
//

import UIKit

class ImageNewsCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageNews: UIImageView!
	
	func configeure(image: UIImage?) {
		imageNews.image = image
	}
}
