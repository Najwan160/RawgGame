//
//  FavoriteInteractor.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let gameRepository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.gameRepository = repository
    }
    
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error> {
        gameRepository.getFavorite()
    }
    
}
