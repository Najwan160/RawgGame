//
//  DetailResponse.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation

// MARK: - DetailGames
struct DetailGames: Codable {
    let gameId: Int
    let name: String?
    let backgroundImage: String?
    let released: String?
    let rating: Double?
    let descriptionRaw: String
    let website: String
    
    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case name, released
        case backgroundImage = "background_image"
        case rating
        case descriptionRaw = "description_raw"
        case website
    }
}
