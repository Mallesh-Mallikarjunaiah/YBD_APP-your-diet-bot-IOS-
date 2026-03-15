import Foundation
import FirebaseAuth
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    // These property wrappers MUST be inside the class brackets { }
    @Published var userSession: FirebaseAuth.User?
    @Published var isEmailVerified: Bool = false
    @Published var isProfileCompleted: Bool = false // Added for ContentView logic
    @Published var errorMessage: String?
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.isEmailVerified = Auth.auth().currentUser?.isEmailVerified ?? false
        // In a real app, you'd fetch the profile status from Firestore here
    }
    
    // MARK: - Login
    func login(email: String, password: String) {
        self.errorMessage = nil
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            self.fetchUser()
        }
    }
    
    // MARK: - Sign Up
    func signUp(email: String, password: String, username: String, completion: @escaping (Bool) -> Void) {
        self.errorMessage = nil
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            
            // Set Username
            let changeRequest = result?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("Error setting username: \(error)")
                }
            }
            
            // Send Verification Email
            result?.user.sendEmailVerification { error in
                if let error = error {
                    self.errorMessage = "Failed to send verification email: \(error.localizedDescription)"
                }
            }
            
            self.fetchUser()
            completion(true)
        }
    }
    
    // MARK: - Check Verification
    func checkEmailVerification() {
        Auth.auth().currentUser?.reload { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            self.fetchUser()
        }
    }
    
    // MARK: - Sign Out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.isEmailVerified = false
            self.isProfileCompleted = false
        } catch {
            self.errorMessage = "Failed to sign out."
        }
    }
    
    private func fetchUser() {
        self.userSession = Auth.auth().currentUser
        self.isEmailVerified = Auth.auth().currentUser?.isEmailVerified ?? false
    }
}
