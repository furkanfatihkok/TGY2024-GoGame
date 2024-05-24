//
//  FavouriteViewController.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: FavouriteCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavouriteCell.identifier)
    }

}

extension FavouriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.identifier, for: indexPath) as? FavouriteCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
