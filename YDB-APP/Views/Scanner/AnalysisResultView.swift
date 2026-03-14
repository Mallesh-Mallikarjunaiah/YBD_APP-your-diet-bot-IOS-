import SwiftUI

struct AnalysisResultView: View {
    let image: UIImage?
    @State private var isAnalyzing = true
    @State private var healthScore: Int = 0
    @State private var calories: Int = 0
    @State private var nutritionInfo: String = "Analyzing meal..."

    var body: some View {
        VStack(spacing: 30) {
            if isAnalyzing {
                VStack(spacing: 20) {
                    ProgressView()
                        .scaleEffect(2.0)
                    Text("Gemini AI is analyzing your food...")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            } else {
                // The Result UI
                VStack(spacing: 20) {
                    // Health Score Ring
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        Circle()
                            .trim(from: 0, to: CGFloat(healthScore) / 100)
                            .stroke(healthScore > 70 ? Color.green : Color.orange, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        Text("\(healthScore)%")
                            .font(.system(size: 40, weight: .bold))
                    }

                    Text("Estimated Calories: \(calories) kcal")
                        .font(.title3).bold()

                    Text(nutritionInfo)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            analyzeImage()
        }
        .navigationTitle("YDB Analysis")
    }

    func analyzeImage() {
        guard let image = image else { return }
        
        NutritionService.shared.analyzeFoodImage(image: image) { jsonString in
            guard let data = jsonString?.data(using: .utf8) else { return }
            
            DispatchQueue.main.async {
                do {
                    // This decodes the JSON response from Gemini
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        self.healthScore = json["health_score"] as? Int ?? 0
                        self.calories = json["calories"] as? Int ?? 0
                        self.nutritionInfo = json["advice"] as? String ?? "Analysis complete."
                        self.isAnalyzing = false
                    }
                } catch {
                    print("JSON Parsing Error: \(error)")
                    self.isAnalyzing = false
                }
            }
        }
    }
