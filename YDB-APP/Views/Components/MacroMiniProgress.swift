import SwiftUI

struct MacroMiniProgress: View {
    let label: String
    let color: Color
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.caption).bold()
            ProgressView(value: value)
                .accentColor(color)
                .scaleEffect(x: 1, y: 2, anchor: .center)
        }
    }
}
