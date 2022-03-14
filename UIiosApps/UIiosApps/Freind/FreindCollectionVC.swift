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
		guard let user = user else { return }
		if user.fotos.isEmpty {
			VCAPIService.shared.loadPhotos(ownerId: String(user.id)) { [weak self] data in
				do {
					let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data as! Data)
					for photo in photoResponse.photos {
						if !photo.sizes.isEmpty {
							self?.user?.fotos.append(photo.sizes[0].photo)
							DispatchQueue.main.async {
								self?.collectionView.reloadData()
							}
						}
					}
				} catch {
					debugPrint(error.localizedDescription)
				}
			}
			
		}
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return user?.fotos.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idFreindCell", for: indexPath) as! FreindCell
		if let user = user {
			cell.configureCell(photo: user.fotos[indexPath.row]!)
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
