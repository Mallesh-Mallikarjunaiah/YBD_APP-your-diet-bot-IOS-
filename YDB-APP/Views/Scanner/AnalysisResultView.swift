import SwiftUI

struct AnalysisResultView: View {
    let image: UIImage?
    
    // Mock data for now (In Phase 3, this comes from AI API)
    let healthScore: Int = 85
    let calories: Int = 450
    let protein: Int = 32
    let carbs: Int = 40
    let fat: Int = 12
    
    var body: some View {
        VStack(spacing: 25) {
            // Health Score Gauge
            ZStack {
                Circle()
                    .trim(from: 0, to: 1.0)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                    .frame(width: 150, height: 150)
                
                Circle()
                    .trim(from: 0, to: CGFloat(healthScore) / 100)
                    .stroke(healthScore > 70 ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                    .frame(width: 150, height: 150)
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(healthScore)%")
                        .font(.system(size: 40, weight: .bold))
                    Text("Health Score")
                        .font(.caption).foregroundColor(.gray)
                }
            }
            .padding(.top)

            Text(healthScore >= 80 ? "This meal is excellent for your goals!" : "Try to reduce fats in your next meal.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Macro Breakdown
            VStack(spacing: 15) {
                NutritionRow(label: "Calories", value: "\(calories) kcal")
                NutritionRow(label: "Protein", value: "\(protein)g")
                NutritionRow(label: "Carbs", value: "\(carbs)g")
                NutritionRow(label: "Fat", value: "\(fat)g")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .padding(.horizontal)

            Button("Add to Daily Log") {
                // Logic to add to the dashboard totals
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle("YDB Analysis")
    }
}

struct NutritionRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label).bold()
            Spacer()
            Text(value).foregroundColor(.blue)
        }
    }
}
