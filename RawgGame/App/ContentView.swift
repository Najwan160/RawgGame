//
//  ContentView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Kingfisher
import SwiftUI

struct ContentView: View {
    @State var searchedGame = 0
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var searchPresenter: SearchPresenter
    @EnvironmentObject var profilePresenter: ProfilePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        TabView(selection: $searchedGame) {
            HomeView(presenter: homePresenter).tabItem {
                Label("Home", systemImage: "house")
            }.tag(0)
            SearchView(presenter: searchPresenter).tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }.tag(1)
            FavoriteView(presenter: favoritePresenter).tabItem {
                Label("Favorite", systemImage: "heart.fill")
            }.tag(2)
            ProfileView(presenter: profilePresenter).tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
