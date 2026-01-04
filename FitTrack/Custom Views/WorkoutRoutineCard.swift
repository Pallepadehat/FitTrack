import SwiftUI

struct WorkoutRoutineCard: View {
    let routineName: String
    let exerciseCount: Int
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Top Right Menu
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "ellipsis")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.secondary)
                        .padding(8) // Increased touch area visually
                }
                Spacer()
            }
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                Text(routineName)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true) // Allow text to grow vertically if needed
                
                Text("\(exerciseCount) exercises")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 4) // Slight bottom padding adjustment
        }
        .padding(16)
        .frame(maxWidth: .infinity) // Fill grid cell
        .frame(height: 120) // Slightly shorter for a cleaner look, or keep 140 if content needs it. Let's try 130.
        .glassEffect(in: .rect)
        .cornerRadius(24)
        // Add a subtle border or shadow if "glassEffect" isn't distinct enough, but stick to glass for now.
    }
}

#Preview {
    ZStack {
        Color.black
        HStack {
            WorkoutRoutineCard(routineName: "Friday - Upper Body", exerciseCount: 5)
            WorkoutRoutineCard(routineName: "Monday - Push", exerciseCount: 6)
        }
    }
}
