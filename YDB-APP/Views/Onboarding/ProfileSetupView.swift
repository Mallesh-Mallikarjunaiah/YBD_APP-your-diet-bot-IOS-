import SwiftUI

struct ProfileSetupView: View {
    @State private var gender: Gender = .male
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var activity: ActivityLevel = .moderatelyActive
    
    var body: some View {
        Form {
            Section(header: Text("Physical Metrics")) {
                Picker("Gender", selection: $gender) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                
                TextField("Height (cm)", text: $height)
                    .keyboardType(.decimalPad)
                
                TextField("Weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Workout Intensity")) {
                Picker("Activity Level", selection: $activity) {
                    Text("Sedentary").tag(ActivityLevel.sedentary)
                    Text("Lightly Active").tag(ActivityLevel.lightlyActive)
                    Text("Moderate").tag(ActivityLevel.moderatelyActive)
                    Text("Very Active").tag(ActivityLevel.veryActive)
                }
            }
            
            Section {
                NavigationLink(destination: DietaryRestrictionsView()) {
                    Text("Next: Dietary Restrictions")
                        .bold()
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationTitle("Profile Setup")
    }
}
