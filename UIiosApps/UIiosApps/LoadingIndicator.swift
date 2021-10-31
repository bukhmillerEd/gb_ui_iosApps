//
//  LoadingIndicator.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 30.10.2021.
//

import Foundation
import UIKit

class LoadingIndicator: UIView {
	
	private let point1 = UIView()
	private let point2 = UIView()
	private let point3 = UIView()
	private let container = UIStackView()
	private var points: [UIView] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		self.backgroundColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.5121342741)
		
		container.axis = .horizontal
		container.distribution = .equalSpacing
		container.spacing = 5
		container.alignment = .center
		container.translatesAutoresizingMaskIntoConstraints = false
		addSubview(container)
		
		NSLayoutConstraint.activate([
			container.centerXAnchor.constraint(equalTo: centerXAnchor),
			container.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		let points = [point1, point2, point3]
		for (index, point) in points.enumerated() {
			point.backgroundColor = .black
			point.layer.cornerRadius = 10
			animate(point, Double(index) * 0.25)
			NSLayoutConstraint.activate([
				point.heightAnchor.constraint(equalToConstant: 20),
				point.widthAnchor.constraint(equalToConstant: 20)
			])
			container.addArrangedSubview(point)
		}
	}
	
	private func animate(_ point: UIView, _ delay: TimeInterval) {
		UIView.animate(withDuration: 0.75, delay: delay, options: [.repeat, .autoreverse]) {
			point.alpha = 0
		}
	}
	
}
