//
//  FavoritePresenter.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    @Published var favorites: [FavoriteEntities] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    init(useCase: FavoriteUseCase) {
        self.favoriteUseCase = useCase
    }
    
    func getFavorite() {
        favoriteUseCase.getFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { favorite in
                self.favorites = favorite
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        gameListModel: GameListModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: gameListModel)) { content() }
    }
}
