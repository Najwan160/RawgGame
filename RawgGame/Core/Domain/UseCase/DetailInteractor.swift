//
//  DetailInteractor.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getDetail(id: Int) -> AnyPublisher<[GameDetailModel], Error>
    func addFavorite(gameListModel: GameListModel) -> AnyPublisher<Bool, Error>
    func deleteFavorite(primaryKey: Int) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let gameRepository: GameRepositoryProtocol
    private let detail: GameListModel
    
    required init(repository: GameRepositoryProtocol, detail: GameListModel) {
        self.gameRepository = repository
        self.detail = detail
    }
    
    func getDetail(id: Int) -> AnyPublisher<[GameDetailModel], Error> {
        return gameRepository.getDetail(id: id)
    }
    
    func addFavorite(gameListModel: GameListModel) -> AnyPublisher<Bool, Error> {
        return gameRepository.addFavorite(from: gameListModel)
    }
    
    func deleteFavorite(primaryKey: Int) -> AnyPublisher<Bool, Error> {
        return gameRepository.deleteFavorite(from: primaryKey)
    }
    
}
