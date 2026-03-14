import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                // YDB Logo
                VStack {
                    Image(systemName: "leaf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                    
                    Text("YDB")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    Text("Your Diet Bot")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 50)
                
                // Login Fields
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                // Login Button
                Button(action: loginUser) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Link to Signup
                NavigationLink(destination: ProfileSetupView()) {
                    Text("Don't have an account? Sign Up")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
        }
    }
    
    func loginUser() {
        AuthService.shared.login(email: email, password: password) { result in
            switch result {
            case .success:
                print("Login Success!")
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
