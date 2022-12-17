//
//  FavoriteView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//
//
import SwiftUI
import Kingfisher

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        NavigationView {
            List {
                ForEach(presenter.favorites) { favorite in
                    presenter.linkBuilder(gameListModel: GameListModel(gameId: favorite.gameId, name: favorite.title, released: favorite.released, backgroundImage: favorite.image, rating: favorite.rating)) {
                        FavoriteItem(backroundImage: favorite.image, released: favorite.released, rating: favorite.rating, name: favorite.title)
                    }
                }
            }
            .onAppear {
                presenter.getFavorite()
            }
        }
    }
}

struct FavoriteItem: View {
    var backroundImage: String
    var released: String
    var rating: Double
    var name: String
    var body: some View {
        HStack {
            KFImage(URL(string: backroundImage) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"))
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        
        VStack(alignment: .leading) {
            Text(name)
                .padding(7)
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundColor(.yellow)
                Text(String(rating))
            }
        }
    }
}
