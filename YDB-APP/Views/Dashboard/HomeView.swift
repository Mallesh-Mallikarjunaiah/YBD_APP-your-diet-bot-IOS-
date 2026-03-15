import SwiftUI
import FirebaseAuth
struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    let dailyGoal: Double = 2200
    @State private var consumed: Double = 1450
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 25) {
                
                // USER DASHBOARD CARD
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Welcome")
                                .font(.headline)
                            
                            Text(authViewModel.userSession?.email ?? "User")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
                
                
                // Daily Progress Ring
                HStack {
                    
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(consumed / dailyGoal))
                            .stroke(Color.green, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                        
                        VStack {
                            Text("\(Int(dailyGoal - consumed))")
                                .font(.system(size: 40, weight: .bold))
                            
                            Text("kcal left")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(width: 180, height: 180)
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        MacroMiniProgress(label: "Protein", color: .blue, value: 0.7)
                        MacroMiniProgress(label: "Carbs", color: .orange, value: 0.5)
                        MacroMiniProgress(label: "Fats", color: .red, value: 0.4)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
                
                
                // Diet Chart
                Text("Today's Diet Chart")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 15) {
                    MealRow(time: "Breakfast", suggestion: "Oats with protein powder & berries", icon: "sun.max.fill")
                    MealRow(time: "Lunch", suggestion: "Grilled chicken/Tofu with quinoa salad", icon: "sun.horizon.fill")
                    MealRow(time: "Dinner", suggestion: "Baked fish & steamed broccoli", icon: "moon.stars.fill")
                }
                
                
                // Scan Meal Button
                NavigationLink(destination: CameraView()) {
                    
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Scan My Meal to Find Nutrition")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .navigationBarBackButtonHidden(true)
        
        // LOGOUT BUTTON
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    authViewModel.signOut()
                }
                .foregroundColor(.red)
            }
        }
    }
}
