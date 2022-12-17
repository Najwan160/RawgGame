//
//  ProfilePresenter.swift
//  RawgGame
//
//  Created by Muhammad Najwan Latief on 05/12/22.
//

import Foundation

class ProfilePresenter: ObservableObject {
    
    private let profileUseCase: ProfileUseCase
    @Published var name = ""
    @Published var imagePath = ""
    @Published var email = ""
    
    init(useCase: ProfileUseCase) {
        self.profileUseCase = useCase
    }
    
    func getProfile() {
        let profile = profileUseCase.getProfile()
        self.name = profile.name
        self.imagePath = profile.imagePath
        self.email = profile.email
    }
    
}
