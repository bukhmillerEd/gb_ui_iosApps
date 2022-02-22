//
//  FotosVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 06.11.2021.
//

import UIKit

class FotosVC: UIViewController {
	
	@IBOutlet weak var fotoImg: UIImageView!
	
	var user: User?
	private var indexCurentFoto = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let user = user, user.fotos.count > 0 {
			fotoImg.image = user.fotos[0]
		}
		
		addSwipeGestureRecognizer()
	}
	
	@objc func processSwipeRight(gesture: UISwipeGestureRecognizer) {
		guard let user = user else { return }
		if gesture.direction == .left {
			indexCurentFoto = min(user.fotos.count - 1, indexCurentFoto + 1)
		} else if gesture.direction == .right {
			indexCurentFoto = max(0, indexCurentFoto - 1)
		}
		
		UIView.animate(withDuration: 1.0, animations: {() -> Void in
			self.fotoImg?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)},
									 completion: {_ in
			self.fotoImg.image = user.fotos[self.indexCurentFoto]
			self.showFotoAnimate(gesture: gesture)
		})
	}
	
	private func showFotoAnimate(gesture: UISwipeGestureRecognizer) {
		var offset = view.bounds.width
		if gesture.direction == .right {
			offset = -offset
		}
		
		fotoImg.transform = CGAffineTransform(translationX: offset, y: 0)
		UIView.animate(withDuration: 0.5,
									 delay: 0,
									 options: .curveEaseOut,
									 animations: { [weak self] in
			self?.fotoImg.transform = .identity
		}, completion: nil)
	}
	
	private func addSwipeGestureRecognizer() {
		let gestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(processSwipeRight(gesture:)))
		gestureLeft.direction = .left
		fotoImg.isUserInteractionEnabled = true
		fotoImg.addGestureRecognizer(gestureLeft)
		
		let gestureRight = UISwipeGestureRecognizer(target: self, action: #selector(processSwipeRight(gesture:)))
		gestureRight.direction = .right
		fotoImg.isUserInteractionEnabled = true
		fotoImg.addGestureRecognizer(gestureRight)
	}
	
}
