//
//  SignInEmailView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Chetan Choudhary on 19/06/23.
//

import SwiftUI



struct SignInEmailView: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    }
                    catch{
                        print("Error\(error)")
                    }
                    
                    do{
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    }
                    catch{
                        print("Error\(error)")
                    }
                }
                
            }label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationTitle("Sign In with email")
        .padding()
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInEmailView(showSignInView: .constant(false))
        }
    }
}
