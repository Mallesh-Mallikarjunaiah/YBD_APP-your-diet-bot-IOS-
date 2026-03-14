import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    static let shared = AuthService()
    private let db = Firestore.firestore()
    
    // Create a new user and save their profile
    func signUp(email: String, password: String, profile: UserProfile, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let uid = authResult?.user.uid else { return }
            
            // Save the user data to Firestore
            do {
                try self.db.collection("users").document(uid).setData(from: profile)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // Login existing user
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
