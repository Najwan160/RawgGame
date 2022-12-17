//
//  GameRepository.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
    
    func getList() -> AnyPublisher<[GameListModel], Error>
    func getDetail(id: Int) -> AnyPublisher<[GameDetailModel], Error>
    func getSearch(query: String) -> AnyPublisher<[GameListModel], Error>
    func getProfile() -> ProfileEntity
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error>
    func addFavorite(from gameListModel: GameListModel) -> AnyPublisher<Bool, Error>
    func deleteFavorite(from primaryKey: Int) -> AnyPublisher<Bool, Error>
}

final class GameRepository: NSObject {
    
    typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: MealInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension GameRepository: GameRepositoryProtocol {
    
    func getList() -> AnyPublisher<[GameListModel], Error> {
        return self.remote.getList()
            .map { GameListMapper.mapGameListResponsesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    
    func getDetail(id: Int) -> AnyPublisher<[GameDetailModel], Error> {
        return self.remote.getDetail(id: id)
            .map { GameDetailMapper.mapGameDetailResponsesToDomains(detailGames: $0)}
            .eraseToAnyPublisher()
    }
    
    func getSearch(query: String) -> AnyPublisher<[GameListModel], Error> {
        return self.remote.getSearch(query: query)
            .map { GameListMapper.mapGameListResponsesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    
    func getProfile() -> ProfileEntity {
        return self.locale.getProfile()
    }
    
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error> {
        return self.locale.getFavorite()
    }
    
    func addFavorite(from gameListModel: GameListModel) -> AnyPublisher<Bool, Error> {
        let favorite = FavoriteMapper.mapGameDetailModelToFavoriteEntities(detailGames: gameListModel)
        return self.locale.addFavorite(from: favorite)
    }
    
    func deleteFavorite(from primaryKey: Int) -> AnyPublisher<Bool, Error> {
        return self.locale.deleteFavorite(from: primaryKey)
    }
}
