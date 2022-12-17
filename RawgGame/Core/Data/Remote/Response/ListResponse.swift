//
//  ListResponse.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation

// MARK: - ListGames
struct ListGames: Codable {
    let games: [ListResult]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
} 

// MARK: - ListResult
struct ListResult: Codable {
    let gameId: Int
    let name, released: String?
    let backgroundImage: String?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case name, released
        case backgroundImage = "background_image"
        case rating
    }
    
}
