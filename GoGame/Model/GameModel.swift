//
//  GameModel.swift
//  GoGame
//
//  Created by FFK on 20.05.2024.
//

import Foundation

struct GameResponse: Decodable {
    let results: [GameModel]
}

struct GameModel: Decodable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
    }
}

struct GameDetail: Decodable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case released
        case backgroundImage = "background_image"
    }
}


