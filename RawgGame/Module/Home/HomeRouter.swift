//
//  HomeRouter.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for detail: GameListModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(detail: detail)
        let presenter = DetailPresenter(useCase: detailUseCase)
        return DetailView(presenter: presenter, games: detail)
    }
    
}
