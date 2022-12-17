//
//  RawgGameApp.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI

@main
struct RawgGameApp: App {
    var body: some Scene {
        WindowGroup {
            let homeUseCase = Injection.init().provideHome()
            let homePresenter = HomePresenter(useCase: homeUseCase)
            
            let searchUseCase = Injection.init().provideSearch()
            let searchPresenter = SearchPresenter(useCase: searchUseCase)
            
            let profileUseCase = Injection.init().provideProfile()
            let profilePresenter = ProfilePresenter(useCase: profileUseCase)
            
            let favoriteUseCase = Injection.init().provideFavorite()
            let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)
            
            ContentView().environmentObject(homePresenter).environmentObject(searchPresenter).environmentObject(profilePresenter).environmentObject(favoritePresenter)
        }
    }
}
