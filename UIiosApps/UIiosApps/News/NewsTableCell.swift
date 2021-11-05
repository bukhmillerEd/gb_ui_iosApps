//
//  NewsTableCell.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 24.10.2021.
//

import UIKit

class NewsTableCell: UITableViewCell, UICollectionViewDelegate {
	
	@IBOutlet weak var imageAuthor: AvatarCustomView!
	@IBOutlet weak var authorLbl: UILabel!
	@IBOutlet weak var dateLbl: UILabel!
	@IBOutlet weak var textTV: UITextView!
	@IBOutlet weak var imageCV: ImageNewsCollectionView!
	
	private var news: News?
	
	override func awakeFromNib() {
		imageCV.dataSource = self
		imageCV.delegate = self
	}
	
	func configure(news: News) {
		imageAuthor.img = news.author.avatar
		authorLbl.text = news.author.name
		dateLbl.text = news.date
		textTV.text = news.text
		
		self.news = news
	}

}

extension NewsTableCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return news?.images.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCellID", for: indexPath) as! ImageNewsCollectionViewCell
		cell.configeure(image: news?.images[indexPath.row])
		return cell
	}

}

