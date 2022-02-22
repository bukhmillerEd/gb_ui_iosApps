//
//  FrendCollectionVC.swift
//  UIiosApps
//
//  Created by Эдуард Бухмиллер on 14.10.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class FreindCollectionVC: UICollectionViewController {
	var user: User?

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idFreindCell", for: indexPath) as! FreindCell
		if let user = user {
			cell.configureCell(user: user)
		}
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "idFotosSegue") {
			guard let destination = segue.destination as? FotosVC else { return }
			destination.user = user
		}
	}
	
}
