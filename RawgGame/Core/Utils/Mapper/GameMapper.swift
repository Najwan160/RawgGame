//
//  GameMapper.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation

final class GameListMapper {
    
    static func mapGameListResponsesToDomains(
        input gameListResponses: [ListResult]
    ) -> [GameListModel] {
        
        return gameListResponses.map { result in
            return GameListModel(
                gameId: result.gameId,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
        }
    }
}

final class GameDetailMapper {
    
    static func mapGameDetailResponsesToDomains(
        detailGames: [DetailGames]
    ) -> [GameDetailModel] {
        return detailGames.map { detailGame in
            return GameDetailModel(
                gameId: detailGame.gameId,
                name: detailGame.name,
                image: detailGame.backgroundImage,
                rating: detailGame.rating,
                released: detailGame.released,
                description: detailGame.descriptionRaw
            )
        }
    }
}

final class FavoriteMapper {
    
    static func mapGameDetailModelToFavoriteEntities(
        detailGames: GameListModel
    ) -> FavoriteEntities {
        let newFavorite = FavoriteEntities()
        newFavorite.gameId = detailGames.gameId
        newFavorite.title = detailGames.name ?? "Unknown"
        newFavorite.image = detailGames.backgroundImage ?? "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"
        newFavorite.released = detailGames.released ?? "Unknown"
        newFavorite.rating = detailGames.rating ?? 0.0
        return newFavorite
    }
}
