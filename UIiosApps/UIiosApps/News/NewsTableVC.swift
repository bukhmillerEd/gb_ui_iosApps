//
//  NewsTableVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 24.10.2021.
//

import UIKit

class NewsTableVC: UITableViewController {
	
	private var news: [News] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		getNews()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return news.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellID", for: indexPath) as! NewsTableCell
		cell.configure(news: news[indexPath.row])
		return cell
	}
	
	private func getNews() {
		let newsLoaderService = NewsLoaderService()
		news = newsLoaderService.getNews()
	}
	
	
}
