//
//  LocaleDataSource.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine
import RealmSwift

protocol LocaleDataSourceProtocol: class {
    
    func getProfile() -> ProfileEntity
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error>
    func addFavorite(from favorite: FavoriteEntities) -> AnyPublisher<Bool, Error>
    func deleteFavorite(from primaryKey: Int) -> AnyPublisher<Bool, Error>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getProfile() -> ProfileEntity {
        return ProfileEntity(name: "Muhammad Najwan Latief", email: "najwan160@gmail.com", imagePath: "aku")
    }
    
    func addFavorite(from favorite: FavoriteEntities) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(favorite, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    print("GAGAL")
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                print("YANG INI GAGALNYA")
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavorite() -> AnyPublisher<[FavoriteEntities], Error> {
        return Future<[FavoriteEntities], Error> { completion in
            if let realm = self.realm {
                let favorites: Results<FavoriteEntities> = {
                    realm.objects(FavoriteEntities.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                completion(.success(favorites.toArray(ofType: FavoriteEntities.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteFavorite(from primaryKey: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                if let favorite = realm.object(ofType: FavoriteEntities.self, forPrimaryKey: primaryKey) {
                    do {
                        try realm.write {
                            realm.delete(favorite)
                            completion(.success(true))
                        }
                    } catch {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                } else {
                    completion(.failure(DatabaseError.itemNotFound))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
