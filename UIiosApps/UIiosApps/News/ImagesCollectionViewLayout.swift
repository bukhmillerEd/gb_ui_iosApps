//
//  ImagesCollectionViewLayout.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 25.10.2021.
//

import UIKit

class ImagesCollectionViewLayout: UICollectionViewLayout {

	var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]() // Хранит атрибуты для заданных индексов
	var columnsCount = 1                  // Количество столбцов
	var cellHeight: CGFloat = 128         // Высота ячейки
	private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
	
	override func prepare() {
		self.cacheAttributes = [:] // Инициализируем атрибуты
		// Проверяем наличие collectionView
		guard let collectionView = self.collectionView else { return }
		let itemsCount = collectionView.numberOfItems(inSection: 0)
		// Проверяем, что в секции есть хотя бы одна ячейка
		guard itemsCount > 0 else { return }
		
		var imageWidth: CGFloat = 0
		var imageHeight: CGFloat = 0
		var x: CGFloat = 0
		var y: CGFloat = 0
		
		for item in 1...min(itemsCount, 4) {
			if itemsCount == 1 {
				imageWidth = collectionView.frame.width
				imageHeight = collectionView.frame.height
			} else if itemsCount == 2 {
				imageWidth = collectionView.frame.width / 2
				imageHeight = collectionView.frame.height
			} else if itemsCount == 3 {
				if item == 3 {
					imageWidth = collectionView.frame.width
				} else {
					imageWidth = collectionView.frame.width / 2
				}
				imageHeight = collectionView.frame.height / 2
			} else if itemsCount >= 4 {
				imageWidth = collectionView.frame.width / 2
				imageHeight = collectionView.frame.height / 2
			}
			installFrame(item: item-1, x: x, y: y, imageWidth: imageWidth, imageHeight: imageHeight)
			switch item {
			case 1:
				x = imageWidth
				y = 0
			case 2:
				x = 0
				y = imageHeight
			case 3:
				x = imageWidth
				y = imageHeight
			default: break
			}
			self.totalCellsHeight += imageHeight
		}
	}
	
	private func installFrame(item: Int, x: CGFloat, y: CGFloat, imageWidth: CGFloat, imageHeight: CGFloat) {
		let indexPath = IndexPath(item: item, section: 0)
		let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
		attributes.frame = CGRect(x: x, y: y, width: imageWidth, height: imageHeight)
		cacheAttributes[indexPath] = attributes
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return cacheAttributes.values.filter { attributes in
			return rect.intersects(attributes.frame)
		}
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return cacheAttributes[indexPath]
	}
	
	override var collectionViewContentSize: CGSize {
		return CGSize(width: self.collectionView?.frame.width ?? 0,
									height: self.totalCellsHeight)
	}
	
}
