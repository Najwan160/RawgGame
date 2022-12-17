//
//  DetailPresenter.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var detail: [GameDetailModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    @Published var isFavorite: Bool = false
    
    init(useCase: DetailUseCase) {
        self.detailUseCase = useCase
    }
    
    func getDetail(id: Int) {
        detailUseCase.getDetail(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.detail = games
            })
            .store(in: &cancellables)
    }
    
    func addFavorite(gamesListModel: GameListModel) {
        detailUseCase.addFavorite(gameListModel: gamesListModel)
    }
    
    func deleteFavorite(primaryKey: Int) {
        detailUseCase.deleteFavorite(primaryKey: primaryKey)
    }
}
