//
//  DetailViewModel.swift
//  GoGame
//
//  Created by FFK on 25.05.2024.
//


import Foundation

protocol DetailViewModelProtocol {
    func fetchGameDetails(gameID: Int, completion: @escaping (Result<GameDetail, APIError>) -> Void)
}

final class DetailViewModel: DetailViewModelProtocol {
    func fetchGameDetails(gameID: Int, completion: @escaping (Result<GameDetail, APIError>) -> Void) {
        GameNetworking.shared.fetchGameDetails(gameID: gameID) { response in
            DispatchQueue.main.async {
                completion(response)
            }
        }
    }
}
