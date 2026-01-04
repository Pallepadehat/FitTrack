import SwiftUI

struct MacroCard: View {
    // Props
    let title: String
    let value: Int
    let unit: String
    let icon: String // SF Symbol Name
    let color: Color
    let progress: Double // 0.0 to 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    Text("\(value)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Text(unit)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 4)
            
            // Progress Ring Content
            HStack {
                Spacer()
                ZStack {
                    // Background Track (Light tint of the main color)
                    Circle()
                        .stroke(color.opacity(0.15), lineWidth: 8)
                    
                    // Progress
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(), value: progress)
                    
                    // Icon
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(color)
                }
                .frame(width: 60, height: 50)
                Spacer()
            }
        }
        .padding(16)
        .glassEffect(in: .rect)
        .cornerRadius(20)
    }
}

// Preview helper
struct MacroCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MacroCard(
                title: "Protein left",
                value: 196,
                unit: "g",
                icon: "flame.fill", // Placeholder
                color: .red,
                progress: 0.6
            )
            MacroCard(
                title: "Carbs left",
                value: 120,
                unit: "g",
                icon: "leaf.fill",
                color: .orange,
                progress: 0.4
            )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
