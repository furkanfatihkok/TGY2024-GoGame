//
//  HomeViewModel.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    
    var games: [GameModel] { get }
    var filteredGame: [GameModel] { get }
    
    func fetchGames(completion: @escaping (Result<Void,Error>) -> Void)
    func filterGames(with searchText: String)
}

final class HomeViewModel: HomeViewModelProtocol {
    
    private var allGames: [GameModel] = []
    var games: [GameModel] { allGames }
    var filteredGame: [GameModel] = []
    
    func fetchGames(completion: @escaping (Result<Void,Error>) -> Void) {
        GameNetworking.shared.fetchGames { [weak self] result in
            switch result {
            case .success(let gameResponse):
                self?.allGames = gameResponse.results
                self?.filteredGame = gameResponse.results
                completion(.success(()))
            case .failure(let error):
                print(error.errorMessage)
            }
        }
    }
    
    func filterGames(with searchText: String) {
        if searchText.count > 3 {
            filteredGame = games.filter({ $0.name.lowercased().contains(searchText.lowercased())})
        } else {
            filteredGame = allGames
        }
    }
    
}
