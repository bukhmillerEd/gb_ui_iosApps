//
//  LikeControl.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 19.10.2021.
//

import UIKit

class LikeControl: UIControl {
	
	private var countLikesLbl = UILabel()
	private var likeImgView = UIImageView()
	private var likeStack = UIStackView()
	
	override func draw(_ rect: CGRect) {
		setLikeStack()
		setLikeImgView()
		
	}
	
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		print("beginTracking")
		return true
	}
	
	private func setCountLikesLbl() {
		countLikesLbl.frame = likeStack.bounds
		likeStack.addSubview(countLikesLbl)
	}
	
	private func setLikeStack() {
		likeStack.frame = bounds
		addSubview(likeStack)
	}
	
	private func setLikeImgView() {
		likeImgView.image = UIImage(systemName: "heart")
		likeImgView.tintColor = .black
		//likeImgView.backgroundColor = .red
		likeImgView.frame = .infinite
		
		likeStack.addSubview(likeImgView)

		
		
//		NSLayoutConstraint(item: likeImgView,
//																								 attribute: .trailing,
//																								 relatedBy: .equal,
//																								 toItem: likeImgView.superview,
//																								 attribute: .trailing,
//																								 multiplier: 1,
//																								 constant: 5).isActive = true
//
//		NSLayoutConstraint(item: likeImgView,
//																								 attribute: .top,
//																								 relatedBy: .equal,
//																								 toItem: likeImgView.superview,
//																								 attribute: .top,
//																								 multiplier: 1,
//											 constant: 5).isActive = true
//
//		NSLayoutConstraint(item: likeImgView,
//																								 attribute: .width,
//																								 relatedBy: .equal,
//																								 toItem: nil,
//																								 attribute: .notAnAttribute,
//																								 multiplier: 1,
//											 constant: 25).isActive=true
//
//		NSLayoutConstraint(item: likeImgView,
//																								 attribute: .height,
//																								 relatedBy: .equal,
//																								 toItem: nil,
//																								 attribute: .notAnAttribute,
//																								 multiplier: 1,
//											 constant: 25).isActive = true
		
//		likeImgView.addConstraint(NSLayoutConstraint(item: likeImgView,
//																								 attribute: .trailing,
//																								 relatedBy: .equal,
//																								 toItem: likeImgView.superview,
//																								 attribute: .trailing,
//																								 multiplier: 1,
//																								 constant: 5).isActive = true)
//
//		likeImgView.addConstraint(NSLayoutConstraint(item: likeImgView,
//																								 attribute: .top,
//																								 relatedBy: .equal,
//																								 toItem: likeImgView.superview,
//																								 attribute: .top,
//																								 multiplier: 1,
//																								 constant: 5))
//
//		likeImgView.addConstraint(NSLayoutConstraint(item: likeImgView,
//																								 attribute: .width,
//																								 relatedBy: .equal,
//																								 toItem: nil,
//																								 attribute: .notAnAttribute,
//																								 multiplier: 1,
//																								 constant: 25))
//
//		likeImgView.addConstraint(NSLayoutConstraint(item: likeImgView,
//																								 attribute: .height,
//																								 relatedBy: .equal,
//																								 toItem: nil,
//																								 attribute: .notAnAttribute,
//																								 multiplier: 1,
//																								 constant: 25))
		
		
		
	}

	
}
