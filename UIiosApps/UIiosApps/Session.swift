//
//  Session.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 23.02.2022.
//

import Foundation

class Session {
	static var shared = Session()
	var token: String?
	var userId: Int?
	private init(){}
}
