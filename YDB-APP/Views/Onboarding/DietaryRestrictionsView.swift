import SwiftUI

struct DietaryRestrictionsView: View {
    @State private var restrictions = ["Veg", "Non-veg", "Egg", "Chicken", "Meat", "Fish"]
    @State private var selectedRestrictions: Set<String> = []
    @State private var healthConcerns: String = ""

    var body: some View {
        VStack(spacing: 20) {
            List {
                Section(header: Text("Dietary Restrictions")) {
                    ForEach(restrictions, id: \.self) { item in
                        HStack {
                            Text(item)
                            Spacer()
                            if selectedRestrictions.contains(item) {
                                Image(systemName: "checkmark").foregroundColor(.green)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedRestrictions.contains(item) {
                                selectedRestrictions.remove(item)
                            } else {
                                selectedRestrictions.insert(item)
                            }
                        }
                    }
                }
                
                Section(header: Text("Medical Issues")) {
                    TextEditor(text: $healthConcerns)
                        .frame(height: 100)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.2)))
                }
            }
            
            // Replaced the Button with NavigationLink
            NavigationLink(destination: HomeView()) {
                Text("Complete Setup")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Restrictions")
    }
}
