import SwiftUI

struct EmptyStateCard: View {
    var body: some View {
        VStack(spacing: 24) {
            // Custom Illustration
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 180, height: 80)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .overlay(
                        HStack(spacing: 12) {
                            // Food Icon
                            Circle()
                                .fill(LinearGradient(colors: [.green.opacity(0.2), .green.opacity(0.1)], startPoint: .top, endPoint: .bottom))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: "carrot.fill") // Using carrot as salad/food placeholder
                                        .foregroundColor(.green)
                                        .font(.system(size: 20))
                                )
                            
                            // Skeleton Text
                            VStack(alignment: .leading, spacing: 6) {
                                Capsule()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 8)
                                
                                Capsule()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 50, height: 8)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                    )
            }
            .frame(height: 50)
            
            // Instruction Text
            Text("Tap + to add your first meal of the day")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .glassEffect(in: .rect) // Using user's glass effect
        .cornerRadius(24)
    }
}

struct EmptyStateCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            EmptyStateCard()
                .padding()
        }
    }
}
