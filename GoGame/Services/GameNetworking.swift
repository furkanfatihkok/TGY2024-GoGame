//
//  GameNetworking.swift
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
    
    var errorMessage: String {
        switch self {
        case .requestFailed:
            return "Request failed. Please check your internet connection and try again."
        case .responseUnsuccessful:
            return "Server response was unsuccessful."
        case .invalidData:
            return "Invalid data received from the server."
        case .jsonParsingFailure:
            return "Failed to parse JSON data."
        case .invalidUrl:
            return "Invalid URL provided."
        }
    }
}

final class GameNetworking {
    
    // MARK: - Singleton
    
    static let shared = GameNetworking()
    private init() {}
    
    // MARK: - Properties
    
    let baseURL = "https://api.rawg.io/api/games"
    private let apiKey = "b747ad04c2f14ba68b20fbfcf5bf6002"
    
    // MARK: - Networking Methods
    
    func fetchGames(completion: @escaping (Result<GameResponse, APIError>) -> Void) {
        
        guard let url = URL(string:"\(baseURL)?key=\(apiKey)") else {
            completion(.failure(.invalidUrl))
            print(APIError.invalidUrl)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFailed))
                print(APIError.requestFailed)
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                print(APIError.invalidData)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GameResponse.self, from: data)
                completion(.success(decodedResponse))
               
            } catch {
                completion(.failure(.jsonParsingFailure))
                print(APIError.jsonParsingFailure)
            }
        }
        task.resume()
    }
    
    func fetchGameDetails(gameID: Int, completion: @escaping(Result<GameDetail, APIError>) -> Void) {
        
        guard let url = URL(string: "\(baseURL)/\(gameID)?key=\(apiKey)") else {
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
