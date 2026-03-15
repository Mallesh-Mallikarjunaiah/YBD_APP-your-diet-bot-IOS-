import Foundation
import GoogleGenerativeAI
import UIKit

class NutritionService {
    static let shared = NutritionService()
    
    // 1. Fetch the API Key from Secrets.plist
    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: "GEMINI_API_KEY") as? String else {
            // This will help you debug if the file or key is missing
            print("⚠️ Error: GEMINI_API_KEY not found in Secrets.plist")
            return ""
        }
        return value
    }
    
    // 2. Use 'lazy' so it doesn't try to load the key until the first time it's used
    private lazy var model = GenerativeModel(name: "gemini-1.5-flash", apiKey: apiKey)
    
    func analyzeFoodImage(image: UIImage, completion: @escaping (String?) -> Void) {
        let prompt = """
        Analyze this food image. Provide the response in JSON format:
        {
          "food_name": "name",
          "calories": 0,
          "protein": 0,
          "carbs": 0,
          "fat": 0,
          "health_score": 0,
          "advice": "one sentence advice"
        }
        The health_score should be from 0 to 100 based on nutritional density.
        """
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        
        let parts = [ModelContent.Part.text(prompt), ModelContent.Part.data(mimetype: "image/jpeg", imageData)]
        
        Task {
            do {
                let response = try await model.generateContent(parts)
                completion(response.text)
            } catch {
                print("AI Error: \(error)")
                completion(nil)
            }
        }
    }
}
