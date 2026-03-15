import SwiftUI

struct ProfileSetupView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var age = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var goal = "Lose Weight"
    let goals = ["Lose Weight", "Maintain", "Gain Muscle"]
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Complete Your Profile")
                .font(.largeTitle).bold()
            
            Text("Let's personalize your diet plan")
                .foregroundColor(.gray)
            
            VStack(alignment: .leading) {
                Text("Age").font(.headline)
                TextField("e.g. 25", text: $age).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Weight (kg)").font(.headline).padding(.top)
                TextField("e.g. 70", text: $weight).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Your Goal").font(.headline).padding(.top)
                Picker("Goal", selection: $goal) {
                    ForEach(goals, id: \.self) { Text($0) }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .padding()
            
            Button(action: {
                // Here you would save to Firestore, for now we skip to the app
                authViewModel.isProfileCompleted = true
            }) {
                Text("Start My Journey")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}
