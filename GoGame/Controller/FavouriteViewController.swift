//
//  FavouriteViewController.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit

final class FavouriteViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favouriteGames: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchFavoriteGames()
    }
    
    private func setupCollectionView() {
        
        tableView.register(UINib(nibName: FavouriteCell.identifier, bundle: nil), forCellReuseIdentifier: FavouriteCell.identifier)
    }
    
    private func fetchFavoriteGames() {
        favouriteGames = CoreDataManager.shared.fetchAllGames()
        tableView.reloadData()
    }
}

//MARK: - CollectionView DataSource

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.identifier, for: indexPath) as? FavouriteCell else { fatalError("Unkown FavouriteCell")}
        
        let game = favouriteGames[indexPath.row]
        cell.configure(with: game)
        
        return cell
    }
    

}
