import SwiftUI

struct ContentView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                
                if authViewModel.userSession != nil {
                    
                    if authViewModel.isEmailVerified {
                        
                        if authViewModel.isProfileCompleted {
                            HomeView()
                                .environmentObject(authViewModel)
                        } else {
                            ProfileSetupView()
                                .environmentObject(authViewModel)
                        }
                        
                    } else {
                        VerificationPendingView()
                            .environmentObject(authViewModel)
                    }
                    
                } else {
                    LoginView()
                        .environmentObject(authViewModel)
                }
            }
        }
    }
}



struct VerificationPendingView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "envelope.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Check Your Email")
                .font(.title)
                .bold()
            
            Text("Click the link in the email we sent to verify your account.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button("I've Verified My Email") {
                authViewModel.checkEmailVerification()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("Sign Out") {
                authViewModel.signOut()
            }
            .foregroundColor(.red)
            .padding(.top)
        }
        .padding()
    }
}
