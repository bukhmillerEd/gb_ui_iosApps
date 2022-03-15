//
//  NewsLoaderService.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 24.10.2021.
//

import Foundation
import UIKit

class NewsLoaderService {
	private var news: [News] = []
	
	func getNews() -> [News]{
		loadNews()
		return news
	}
	
	private func loadNews() {
//		news = [
//			News(author: User(name: "Elon Mask", avatar: UIImage(named: "Mask"), fotos: []),
//					 date: "01.10.2021",
//					 text: "Американская компания Tesla подняла цены на флагманские и самые дорогие модели своей линейки – седан Model S и кроссовер Model X – на 5000 долларов. Обновленные прайс-листы уже опубликованы на официальном сайте автопроизводителя.",
//					 images: [UIImage(named: "tesla1")]),
//			News(author: User(name: "Elon Mask", avatar: UIImage(named: "Mask"), fotos: []),
//					 date: "01.10.2021",
//					 text: "Американская компания Tesla подняла цены на флагманские и самые дорогие модели своей линейки – седан Model S и кроссовер Model X – на 5000 долларов. Обновленные прайс-листы уже опубликованы на официальном сайте автопроизводителя.",
//					 images: [UIImage(named: "tesla1"),
//										UIImage(named: "tesla3")
//									 ]),
//			News(author: User(name: "Elon Mask", avatar: UIImage(named: "Mask"), fotos: []),
//					 date: "01.10.2021",
//					 text: "Американская компания Tesla подняла цены на флагманские и самые дорогие модели своей линейки – седан Model S и кроссовер Model X – на 5000 долларов. Обновленные прайс-листы уже опубликованы на официальном сайте автопроизводителя.",
//					 images: [UIImage(named: "tesla1"),
//										UIImage(named: "tesla2"),
//										UIImage(named: "tesla3")
//									 ]),
//			News(author: User(name: "Elon Mask", avatar: UIImage(named: "Mask"), fotos: []),
//					 date: "01.10.2021",
//					 text: "Американская компания Tesla подняла цены на флагманские и самые дорогие модели своей линейки – седан Model S и кроссовер Model X – на 5000 долларов. Обновленные прайс-листы уже опубликованы на официальном сайте автопроизводителя.",
//					 images: [UIImage(named: "tesla1"),
//										UIImage(named: "tesla2"),
//										UIImage(named: "tesla3"),
//										UIImage(named: "tesla4")
//									 ]),
//			News(author: User(name: "Elon Mask", avatar: UIImage(named: "Mask"), fotos: []),
//					 date: "01.10.2021",
//					 text: "Американская компания Tesla подняла цены на флагманские и самые дорогие модели своей линейки – седан Model S и кроссовер Model X – на 5000 долларов. Обновленные прайс-листы уже опубликованы на официальном сайте автопроизводителя.",
//					 images: [UIImage(named: "tesla1"),
//										UIImage(named: "tesla2"),
//										UIImage(named: "tesla2"),
//										UIImage(named: "tesla3"),
//										UIImage(named: "tesla4")
//									 ])
//		]
		
	}
	
}
