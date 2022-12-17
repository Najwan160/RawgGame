//
//  SearchView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter
    @State var text = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("search", text: $text, onCommit: {
                    presenter.getSearch(query: text)
                })
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
                
                List(presenter.list) { game in
                    self.presenter.linkBuilder(for: game) {
                        Item(games: game)
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }
    }
}
