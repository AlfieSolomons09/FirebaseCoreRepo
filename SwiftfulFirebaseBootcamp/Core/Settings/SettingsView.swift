//
//  SettingsView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Chetan Choudhary on 19/06/23.
//

import SwiftUI


struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    }catch{
                            print(error)
                    }
                }
            }
            
            Button(role: .destructive){
                Task{
                    do{
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    }catch{
                            print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            
            if viewModel.authProviders.contains(.email){
                emailSection
            }
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }
            
        }
        .onAppear{
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}

extension SettingsView{
    
    private var emailSection: some View{
        Section {
            Button("Reset Password"){
                Task{
                    do{
                        try await viewModel.resetPassword()
                        print("Password Reset!")
                    }catch{
                            print(error)
                    }
                }
            }
            
            Button("Update Password"){
                Task{
                    do{
                        try await viewModel.updatePassword()
                        print("Password updated!")
                    }catch{
                            print(error)
                    }
                }
            }
            
            Button("Update email"){
                Task{
                    do{
                        try await viewModel.updateEmail()
                        print("updated email!")
                    }catch{
                            print(error)
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }

    }
    
    private var anonymousSection: some View{
        Section {
            Button("Link google Account"){
                Task{
                    do{
                        try await viewModel.linkGoogleAccount()
                        print("google linked!")
                    }catch{
                            print(error)
                    }
                }
            }
            
            Button("Link Email Account"){
                Task{
                    do{
                        try await viewModel.linkEmailAccount()
                        print("linked email!")
                    }catch{
                            print(error)
                    }
                }
            }
        } header: {
            Text("Create Account")
        }

    }
}
