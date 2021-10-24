//
//  AvatarCustomView.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 16.10.2021.
//

import UIKit
import CoreGraphics

@IBDesignable class AvatarCustomView: UIView {
	
	var img: UIImage?
	
	@IBInspectable var radius: CGFloat = 25 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var weightShadow: CGFloat = 6 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var colorShadow: UIColor = .black {
		didSet {
			setNeedsDisplay()
		}
	}
	
	@IBInspectable var OpacityShadow: Float = 0.7 {
		didSet {
			setNeedsDisplay()
		}
	}
	
	override func draw(_ rect: CGRect) {
		
		let containerView = UIView()
		containerView.frame = bounds
		containerView.layer.shadowColor = colorShadow.cgColor
		containerView.layer.shadowOffset = CGSize.zero
		containerView.layer.shadowOpacity = OpacityShadow
		containerView.layer.shadowRadius = weightShadow
		
		let imgView = UIImageView()
		imgView.image = img
		imgView.frame = containerView.bounds
		imgView.contentMode = .scaleAspectFill
		imgView.layer.cornerRadius = radius
		imgView.layer.masksToBounds = true
		
		containerView.addSubview(imgView)
	
		addSubview(containerView)
	}
	
}


