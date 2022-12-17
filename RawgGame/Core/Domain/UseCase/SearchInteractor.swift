//
//  SearchInteractor.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine

protocol SearchUseCase {
    
    func getSearch(query: String) -> AnyPublisher<[GameListModel], Error>
    
}

class SearchInteractor: SearchUseCase {
    
    private let gameRepository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
        self.gameRepository = repository
    }
    
    func getSearch(query: String) -> AnyPublisher<[GameListModel], Error> {
        return gameRepository.getSearch(query: query)
    }
    
}
