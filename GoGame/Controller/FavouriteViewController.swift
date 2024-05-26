//
//  FavouriteViewController.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import UIKit
import CoreData

final class FavouriteViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favouriteGames: [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteGames()
    }
    
    private func setupCollectionView() {
        tableView.register(UINib(nibName: FavouriteCell.identifier, bundle: nil), forCellReuseIdentifier: FavouriteCell.identifier)
    }
    
    func fetchFavoriteGames() {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let game = favouriteGames[indexPath.row]
            CoreDataManager.shared.deleteGame(id: Int64(game.id))
            
            favouriteGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
