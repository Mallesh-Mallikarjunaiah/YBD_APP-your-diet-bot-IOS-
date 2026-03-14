
import Foundation

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
}

enum ActivityLevel: Double, Codable, CaseIterable {
    case sedentary = 1.2        // Little to no exercise
    case lightlyActive = 1.375   // 1-3 days/week
    case moderatelyActive = 1.55 // 3-5 days/week
    case veryActive = 1.725      // 6-7 days/week
    case extraActive = 1.9       // Hard labor or 2x training
}

struct UserProfile: Codable {
    var id: String?
    var name: String
    var gender: Gender
    var age: Int
    var heightCm: Double
    var weightKg: Double
    var activityLevel: ActivityLevel
    var dietaryRestrictions: [String]
    var healthConcerns: String
    
    // MARK: - Calculations
    
    // Basal Metabolic Rate (BMR)
    var bmr: Double {
        if gender == .male {
            return (10 * weightKg) + (6.25 * heightCm) - (5 * Double(age)) + 5
        } else {
            return (10 * weightKg) + (6.25 * heightCm) - (5 * Double(age)) - 161
        }
    }
    
    // Total Daily Energy Expenditure (TDEE) - This accounts for workout intensity
    var tdee: Double {
        return bmr * activityLevel.rawValue
    }
    
    // MARK: - Daily Macro Targets
    // Protein: ~30% of calories (Higher for muscle maintenance)
    var dailyProteinGrams: Double {
        return (tdee * 0.30) / 4
    }
    
    // Carbs: ~40% of calories
    var dailyCarbGrams: Double {
        return (tdee * 0.40) / 4
    }
    
    // Fats: ~30% of calories
    var dailyFatGrams: Double {
        return (tdee * 0.30) / 9
    }
}
