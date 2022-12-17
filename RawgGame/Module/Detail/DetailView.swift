//
//  DetailView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI
import Kingfisher
import Combine

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    var games: GameListModel
    @State var isFavorite: Bool =  false
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    KFImage(URL(string: games.backgroundImage ?? "") ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"))
                        .resizable()
                        .frame(width: 220, height: 220, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text("Released: \(games.released ?? String("Unknown"))")
                            .padding(.bottom)
                        HStack {
                            Text("Rating : \(String(games.rating ?? 0))")
                            Image(systemName: "star.fill")
                                .imageScale(.small)
                                .foregroundColor(.yellow)
                        }
                    }
                }
                if !presenter.loadingState {
                    if presenter.detail[0].description == ""{
                        Text("No Description For This one")
                            .foregroundColor(.black)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                            .padding(.trailing, 10)
                            .padding(.leading, 10)
                    }
                    Text(presenter.detail[0].description!)
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                } else {
                    Text("It's Loading. Please wait 🥺")
                        .foregroundColor(.black)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .padding(.trailing, 10)
                        .padding(.leading, 10)
                }
            }
            .navigationBarTitle("\(games.name!)", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                if !isFavorite {
                    presenter.addFavorite(gamesListModel: games)
                    isFavorite = true
                } else {
                    presenter.deleteFavorite(primaryKey: games.gameId)
                    isFavorite = false
                }
            }) {
                if !isFavorite {
                    Image(systemName: "heart")
                } else {
                    Image(systemName: "heart.fill")
                }
            }
            )
            .onAppear {
                presenter.getDetail(id: games.gameId)
            }
        }
    }
}
