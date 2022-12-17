//
//  FavoriteEntity.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 06/12/22.
//

import Foundation
import RealmSwift

class FavoriteEntities: Object, Identifiable {
    
    @objc dynamic var released: String = ""
    @objc dynamic var gameId: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var rating: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "gameId"
    }
    
}
