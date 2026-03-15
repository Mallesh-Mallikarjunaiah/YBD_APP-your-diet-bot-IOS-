import SwiftUI
import UIKit

// MARK: - Data Model
struct NutritionAnalysis: Codable {
    let food_name: String?
    let calories: Int?
    let protein: Int?
    let carbs: Int?
    let fat: Int?
    let health_score: Int?
    let advice: String?
}

struct AnalysisResultView: View {
    
    let image: UIImage?
    
    @State private var isAnalyzing = true
    @State private var analysis: NutritionAnalysis?
    @State private var errorMessage: String?
    
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
            }
            
            else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            else if let analysis = analysis {
                
                VStack(spacing: 20) {
                    
                    // Health Score Ring
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat((analysis.health_score ?? 0)) / 100)
                            .stroke((analysis.health_score ?? 0) > 70 ? Color.green : Color.orange,
                                    style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        Text("\((analysis.health_score ?? 0))%")
                            .font(.system(size: 40, weight: .bold))
                    }
                    
                    Text("Estimated Calories: \(analysis.calories ?? 0) kcal")
                        .font(.title3)
                        .bold()
                    
                    // Macronutrients
                    HStack(spacing: 12) {
                        InfoBox(title: "Protein", amount: "\(analysis.protein ?? 0) g", color: .blue)
                        InfoBox(title: "Carbs", amount: "\(analysis.carbs ?? 0) g", color: .orange)
                        InfoBox(title: "Fat", amount: "\(analysis.fat ?? 0) g", color: .red)
                    }
                    
                    if let advice = analysis.advice {
                        Text(advice)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            analyzeImage()
        }
        .navigationTitle("YDB Analysis")
    }
    
    
    // MARK: - AI Analysis
    func analyzeImage() {
        
        guard let image = image else {
            errorMessage = "No image provided."
            isAnalyzing = false
            return
        }
        
        NutritionService.shared.analyzeFoodImage(image: image) { jsonString in
            
            DispatchQueue.main.async {
                
                guard let rawString = jsonString else {
                    errorMessage = "AI Analysis failed. Please check API key or internet."
                    isAnalyzing = false
                    return
                }
                
                // Remove markdown formatting
                let cleanedString = rawString
                    .replacingOccurrences(of: "```json", with: "")
                    .replacingOccurrences(of: "```", with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                
                
                // 👉 PASTE YOUR CODE STARTING HERE
                guard let data = cleanedString.data(using: .utf8) else {
                    errorMessage = "Failed to read AI text."
                    isAnalyzing = false
                    return
                }
                
                do {
                    let decodedResult = try JSONDecoder().decode(NutritionAnalysis.self, from: data)
                    self.analysis = decodedResult
                } catch {
                    errorMessage = "Could not decode the nutrition data. Please try another photo."
                }
                
                isAnalyzing = false
            }
        }
    }
} // <-- This closes AnalysisResultView



// MARK: - InfoBox Component
struct InfoBox: View {
    
    let title: String
    let amount: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(amount)
                .font(.subheadline)
                .bold()
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
