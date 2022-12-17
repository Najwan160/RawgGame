//
//  HomePresenter.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var list: [GameListModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    init(useCase: HomeUseCase) {
        self.homeUseCase = useCase
    }
    
    func getList() {
        homeUseCase.getList()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.list = games
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for gameList: GameListModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: gameList)) { content() }
    }
}
