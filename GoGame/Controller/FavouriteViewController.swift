//
//  FavouriteViewController.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit

final class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var favouriteGames: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: FavouriteCell.identifier, bundle: nil), forCellWithReuseIdentifier: FavouriteCell.identifier)
    }
    
}

//MARK: - CollectionView DataSource

extension FavouriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favouriteGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.identifier, for: indexPath) as? FavouriteCell else { return UICollectionViewCell() }
        let game = favouriteGames[indexPath.item]
        cell.configure(with: game)
        return cell
    }
}
