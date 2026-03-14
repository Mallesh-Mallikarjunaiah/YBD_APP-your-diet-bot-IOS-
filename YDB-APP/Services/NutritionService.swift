import Foundation
import GoogleGenerativeAI
import UIKit

class NutritionService {
    static let shared = NutritionService()
    
    // Replace "YOUR_API_KEY" with your actual Gemini API Key from Google AI Studio
    private let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: "AIzaSyDEj09XBCE7DibsGYKp7eNLqaAL-bxQx3Y")
    
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
