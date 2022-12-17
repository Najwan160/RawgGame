//
//  ProfileView.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var presenter: ProfilePresenter
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Image(presenter.imagePath)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100, alignment: .center)
                    .shadow(radius: 10)
                
                Text(presenter.name)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                
                Text(presenter.name)
                    .font(.footnote)
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .onAppear {
                presenter.getProfile()
            }
        }
    }
}
