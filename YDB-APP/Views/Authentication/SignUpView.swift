import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var localError: String? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 20)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let error = localError ?? authViewModel.errorMessage {
                Text(error).foregroundColor(.red).font(.caption).multilineTextAlignment(.center)
            }
            
            Button(action: {
                if password != confirmPassword {
                    localError = "Passwords do not match."
                    return
                }
                if username.isEmpty || email.isEmpty || password.isEmpty {
                    localError = "Please fill in all fields."
                    return
                }
                
                localError = nil
                authViewModel.signUp(email: email, password: password, username: username) { success in
                    if success {
                        // Firebase auto-logs them in, but we will catch them in ContentView
                        // to force them to verify their email.
                    }
                }
            }) {
                Text("Sign Up")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}//
//  SignUpView.swift
//  YDB-APP
//
//  Created by Mallesh Mallikarjunaiah on 15/03/2026.
//

