import SwiftUI

struct WaterIntakeCard: View {
    // Props
    @Binding var amount: Int
    var unit: String = "ml"
    var onAdd: () -> Void
    var onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            // Water Icon
            Image(systemName: "drop.fill") // Using drop for water representation
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue.opacity(0.8))
                .padding(8 )
                .background(Color.blue.opacity(0.1)) // Light blue background for icon
                .cornerRadius(12)
            
            // Text Content
            VStack(alignment: .leading, spacing: 2) {
                Text("Water")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 4) {
                    Text("\(amount) \(unit)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "gearshape") // Gear icon from screenshot "0 ml {gear}"
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Stepper Buttons
            HStack(spacing: 16) {
                // Minus Button
                Button(action: onRemove) {
                    Image(systemName: "minus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.primary)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                // Plus Button
                Button(action: onAdd) {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(
                            Circle()
                                .fill(Color.black)
                        )
                }
            }
        }
        .padding(16)
        .glassEffect(in: .rect) // Using user's glass effect
        .cornerRadius(20)
    }
}

// Preview
struct WaterIntakeCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1)
            WaterIntakeCard(
                amount: .constant(0),
                onAdd: {},
                onRemove: {}
            )
            .padding()
        }
    }
}
