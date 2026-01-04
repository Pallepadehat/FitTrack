import SwiftUI

struct HealthScoreCard: View {
    // Props
    let score: Int
    let maxScore: Int
    let title: String
    let description: String
    
    // Default color for the progress bar
    var progressColor: Color = .green
    
    private var progress: Double {
        guard maxScore > 0 else { return 0 }
        return Double(score) / Double(maxScore)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("\(score)/\(maxScore)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 8)
                    
                    // Progress
                    Capsule()
                        .fill(progressColor)
                        .frame(width: geometry.size.width * CGFloat(progress), height: 8)
                        .animation(.spring(), value: progress)
                }
            }
            .frame(height: 8)
            
            // Description
            Text(description)
                .font(.footnote)
                .foregroundColor(.gray)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(4)
        }
        .padding(16)
        .glassEffect(in: .rect) // Using user's glass effect
        .cornerRadius(20)
    }
}

struct HealthScoreCard_Previews: PreviewProvider {
    static var previews: some View {
        HealthScoreCard(
            score: 7,
            maxScore: 10,
            title: "Health Score",
            description: "You are well below calorie, carb, and fat goals, but need to increase protein for optimal weight loss. Great job staying on track!"
        )
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
