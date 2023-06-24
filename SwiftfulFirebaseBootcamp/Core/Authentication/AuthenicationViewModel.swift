//
//  AuthenicationViewModel.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Chetan Choudhary on 21/06/23.
//

import Foundation

@MainActor
final class AuthenicationViewModel: ObservableObject{

    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    func signInAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
}
