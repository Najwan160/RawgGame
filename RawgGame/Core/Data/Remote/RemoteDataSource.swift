//
//  RemoteDataSource.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    
    func getList() -> AnyPublisher<[ListResult], Error>
    func getDetail(id: Int) -> AnyPublisher<[DetailGames], Error>
    func getSearch(query: String) -> AnyPublisher<[ListResult], Error>
    
}

final class RemoteDataSource: NSObject {
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                fatalError("Couldn't find file 'Info.plist'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'Info.plist'")
            }
            return value
        }
    }
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getSearch(query: String) -> AnyPublisher<[ListResult], Error> {
        return Future<[ListResult], Error> { completion in
            var component = URLComponents()
            component.scheme = "https"
            component.host = "api.rawg.io"
            component.path = "/api/games"
            component.queryItems = [
                URLQueryItem(name: "search", value: query),
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            AF.request(component)
                .validate()
                .responseDecodable(of: ListGames.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.games))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
        }.eraseToAnyPublisher()
    }
    
    func getList() -> AnyPublisher<[ListResult], Error> {
        return Future<[ListResult], Error> { completion in
            if let url = URL(string: "https://api.rawg.io/api/games?key=\(self.apiKey)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: ListGames.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.games))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetail(id: Int) -> AnyPublisher<[DetailGames], Error> {
        return Future<[DetailGames], Error> { completion in
            if let url = URL(string: "https://api.rawg.io/api/games/\(id)?key=\(self.apiKey)") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailGames.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success([value]))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
