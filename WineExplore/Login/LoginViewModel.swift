//
//  LoginViewModel.swift
//  WineExplore
//
//  Created by Taehyung Lee on 2023/03/19.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class LoginViewModel:ObservableObject {
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
