//
//  Networking.swift
//  GoGame
//
//  Created by FFK on 20.05.2024.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonParsingFailure
    case invalidUrl
}

final class Networking {
    
    static let shared = Networking()
    
    private let baseURL = "https://api.rawg.io/api/games"
    private let apiKey = "b747ad04c2f14ba68b20fbfcf5bf6002"
    
    private init() {}
    
    func fetchGames(completion: @escaping (Result<[Game], APIError>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)?key=\(apiKey)") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GameResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(.jsonParsingFailure))
            }
        }
        task.resume()
    }
    
    func fetchGameDetails(gameID: Int,completion: @escaping(Result<GameDetail, APIError>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)\(gameID)?key=\(apiKey)") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GameDetail.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.jsonParsingFailure))
            }
        }
        task.resume()
    }
}
