import SwiftUI

struct HomeView: View {
    // These would eventually come from your UserProfile model
    let dailyGoal: Double = 2200
    @State private var consumed: Double = 1450
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // 1. Daily Progress Ring
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
                                .font(.caption).foregroundColor(.gray)
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

                // 2. Meal Suggestions Section
                Text("Today's Diet Chart")
                    .font(.title2).bold()
                
                VStack(spacing: 15) {
                    MealRow(time: "Breakfast", suggestion: "Oats with protein powder & berries", icon: "sun.max.fill")
                    MealRow(time: "Lunch", suggestion: "Grilled chicken/Tofu with quinoa salad", icon: "sun.horizon.fill")
                    MealRow(time: "Dinner", suggestion: "Baked fish & steamed broccoli", icon: "moon.stars.fill")
                }
                
                // 3. The "AI Bot" Action Button
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
    }
}

// Reusable Components
struct MacroMiniProgress: View {
    let label: String
    let color: Color
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption).bold()
            ProgressView(value: value)
                .accentColor(color)
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
    }
}

struct MealRow: View {
    let time: String
    let suggestion: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            VStack(alignment: .leading) {
                Text(time).font(.headline)
                Text(suggestion).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}
