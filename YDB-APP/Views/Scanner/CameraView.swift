import SwiftUI

struct HomeView: View {
    // Phase 1 Mock Data (We will connect these to real calculations in Phase 3)
    let dailyGoal: Double = 2200
    @State private var consumed: Double = 1450
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // 1. Calorie Progress Ring (Phase 1 logic)
                ProgressRingView(consumed: consumed, dailyGoal: dailyGoal)
                    .padding(.top)

                // 2. The Diet Bot Chart Section
                Text("Today's Diet Chart")
                    .font(.title2).bold()
                
                VStack(spacing: 15) {
                    MealRow(time: "Breakfast", suggestion: "Oats with protein powder & berries", icon: "sun.max.fill")
                    MealRow(time: "Lunch", suggestion: "Grilled chicken/Tofu with quinoa salad", icon: "sun.horizon.fill")
                    MealRow(time: "Dinner", suggestion: "Baked fish & steamed broccoli", icon: "moon.stars.fill")
                }
                
                // 3. The "AI Bot" Action Button (This addresses your question!)
                // We are using a NavigationLink to present the CameraView.
                NavigationLink(destination: CameraView()) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Scan My Meal")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green) // Changed to green for visibility
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        // Hide the back button so they can't go back to setup
        .navigationBarBackButtonHidden(true)
    }
}

// Simple Ring for UI demonstration (Phase 1)
struct ProgressRingView: View {
    let consumed: Double
    let dailyGoal: Double
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                Circle()
                    .trim(from: 0, to: CGFloat(min(consumed / dailyGoal, 1.0)))
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(Int(dailyGoal - consumed))")
                        .font(.largeTitle).bold()
                    Text("kcal left")
                        .font(.caption).foregroundColor(.gray)
                }
            }
            .frame(width: 150, height: 150)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Protein: 105g / 150g").font(.caption)
                Text("Carbs: 180g / 220g").font(.caption)
                Text("Fats: 45g / 65g").font(.caption)
            }
            .padding(.leading)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
    }
}

// Reusable Meal Row Component
struct MealRow: View {
    let time: String
    let suggestion: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.green)
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
