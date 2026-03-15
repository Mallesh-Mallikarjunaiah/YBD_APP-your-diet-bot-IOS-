import Foundation
import GoogleGenerativeAI
import UIKit

class NutritionService {
    
    static let shared = NutritionService()
    
    // MARK: - API Key
    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: "GEMINI_API_KEY") as? String else {
            print("⚠️ Error: GEMINI_API_KEY not found in Secrets.plist")
            return ""
        }
        return value
    }
    
    // MARK: - Gemini Model
    private lazy var model = GenerativeModel(
        name: "gemini-2.5-flash",
        apiKey: apiKey
    )
    
    
    // MARK: - AI Food Analysis
    func analyzeFoodImage(image: UIImage, completion: @escaping (String?) -> Void) {
        
        let prompt = """
        Analyze this food image and estimate its nutrition.

        Return ONLY JSON in the following format:

        {
          "food_name": "Dish name",
          "calories": 0,
          "protein": 0,
          "carbs": 0,
          "fat": 0,
          "sugar": 0,
          "fiber": 0,
          "sodium_mg": 0,
          "health_score": 0,
          "ingredients": ["ingredient1", "ingredient2"],
          "advice": "One sentence advice to make this meal healthier."
        }

        Rules:
        - health_score must be between 0 and 100
        - macros must be grams
        - sodium should be mg
        - ingredients should be visible ingredients in the food
        - return JSON only (no explanation, no markdown)
        """
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        let content = ModelContent(
            role: "user",
            parts: [
                .text(prompt),
                .data(mimetype: "image/jpeg", imageData)
            ]
        )
        
        Task {
            do {
                let response = try await model.generateContent([content])
                completion(response.text)
            } catch {
                print("AI Error: \(error)")
                completion(nil)
            }
        }
    }
}
