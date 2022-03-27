//
//  AvatarCustomView.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 16.10.2021.
//

import UIKit
import CoreGraphics

@IBDesignable class AvatarCustomView: UIView {
	
	var img: UIImage? = nil
	
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
		
		animateShow(for: containerView)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let animation = CASpringAnimation(keyPath: "transform.scale")
		animation.fromValue = 1
		animation.toValue = 0.8
		animation.stiffness = 100
		animation.mass = 5
		animation.duration = 0.3
		animation.fillMode = CAMediaTimingFillMode.removed
		self.layer.add(animation, forKey: nil)
	}
	
	private func animateShow(for view: UIView) {
		let animation = CASpringAnimation(keyPath: "position.x")
		animation.fromValue = 100
		animation.toValue = 50
		animation.stiffness = 250
		animation.mass = 3
		animation.duration = 1
		animation.fillMode = .removed
		view.layer.add(animation, forKey: nil)
	}
	
}


