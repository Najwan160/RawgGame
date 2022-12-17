//
//  GameListModel.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation

struct GameListModel: Equatable, Identifiable {
    
    let id = UUID()
    let gameId: Int
    let name, released: String?
    let backgroundImage: String?
    var rating: Double?
    
}
