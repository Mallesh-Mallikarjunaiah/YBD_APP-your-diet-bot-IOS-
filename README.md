# YBD_APP-your-diet-bot-IOS-
YDB-App: Your Diet Bot 🥗

YDB-App is a cutting-edge iOS application that leverages the power of Gemini 2.5 Flash to provide instant, visual-based nutritional analysis. By simply photographing a meal, users get immediate access to macronutrient data, health scores, and AI-driven dietary advice.

🚀 Built With

Language: Swift 5.10

UI Framework: SwiftUI

Reactive Framework: Combine

Platform: iOS 17+

Cloud Services: Firebase (Google Cloud Platform)

Authentication: Firebase Auth (Email/Password & Verification)

Database: Cloud Firestore (NoSQL)

AI Engine: Gemini 2.5 Flash API (Multimodal Vision)

SDKs: Google Generative AI Swift SDK, Firebase iOS SDK

Architecture: MVVM (Model-View-ViewModel)

✨ Features

AI Meal Scanning: Take a photo of any dish to identify ingredients and calculate nutrition.

Comprehensive Macros: Tracks Protein, Carbs, Fats, Sugar, and Fiber.

Estimated Micronutrients: Provides estimates for Sodium, Potassium, Vitamin A/C, Calcium, and Iron.

Health Scoring: Instant 1-100 score based on nutritional density.

Persistent Profiles: Your weight, age, and goals are saved securely to the cloud using Firestore.

Secure Onboarding: Full authentication flow including email verification.

Healthy Alternatives: Gemini suggests better meal options to help you reach your goals.

🧪 The Science

The app utilizes the Atwater system to verify calorie estimations based on the identified macronutrients:

$$C_{total} = (4.0 \times P) + (4.0 \times C) + (9.0 \times F)$$

Where $P$, $C$, and $F$ represent the grams of Protein, Carbs, and Fats respectively. The Health Score ($H$) is derived from a weighted density algorithm:

$$H = \sum_{i=1}^{n} (w_i \cdot \text{Nutrient}_i) - \text{Penalty}_{sugar}$$

🛠️ Setup Instructions

Clone the Repository

Firebase Setup:

Add your GoogleService-Info.plist to the project root.

Enable Email/Password authentication in the Firebase Console.

Initialize Firestore in Test Mode (or apply security rules for user paths).

API Keys:

Create a Secrets.plist file.

Add a key named GEMINI_API_KEY with your  API key from Google AI Studio.

Run: Open the .xcodeproj and run on an iPhone simulator or physical device (iOS 17.0+).

📖 Project Story

Inspiration

The inspiration for YDB-App came from a common frustration: manual calorie counting is a chore that leads to burnout. Most health enthusiasts start tracking their food but stop within a week because typing in ingredients is tedious. We built a "second brain" for your diet—an assistant that sees what you see.

Challenges Faced

Data Integrity: AI models can return unpredictable formats. we implemented a "bulletproof" decoding logic using Double types to handle decimal values without crashing.

State Management: We built a centralized Master Router in ContentView to manage the complex flow between login, email verification, and profile setup.

Persistence: By implementing Firestore, we ensured that user data persists across sessions, solving the "data reset" bug encountered during early development.

🎓 What We Learned

This project taught us the importance of Multimodal AI prompting. We learned that the more specific the JSON schema provided to the AI, the more reliable the mobile app becomes. We also gained deep experience in SwiftUI state management and Firebase integration.

Built with ❤️ for the AMC Hackathon.
