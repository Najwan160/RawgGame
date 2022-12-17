//
//  HomeView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    var body: some View {
        NavigationView {
            List(presenter.list) { game in
                self.presenter.linkBuilder(for: game) {
                    Item(games: game)
                }
            }
            .onAppear {
                presenter.getList()
            }
            .navigationBarTitle("Games", displayMode: .inline)
        }
    }
}

struct Item: View {
    var games: GameListModel
    var body: some View {
        HStack {
            KFImage(URL(string: games.backgroundImage ?? "") ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"))
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        
        VStack(alignment: .leading) {
            Text(games.name ?? "Unknown")
                .padding(7)
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundColor(.yellow)
                Text(String(games.rating ?? 0))
            }
        }
    }
}
