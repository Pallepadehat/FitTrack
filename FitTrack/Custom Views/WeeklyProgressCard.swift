import SwiftUI

struct WeeklyProgressCard: View {
    let completedWorkouts: Int
    let totalWorkouts: Int
    
    // Ensure totalWorkouts is at least 1 to avoid division by zero
    private var safeTotal: Int {
        max(1, totalWorkouts)
    }
    
    private var safeCompleted: Int {
        min(completedWorkouts, safeTotal)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Weekly progress")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text("\(safeCompleted) of \(safeTotal) workouts completed")
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            ZStack {
                // Background Ring Segments
                ForEach(0..<safeTotal, id: \.self) { index in
                    SegmentedCircle(
                        startAngle: .degrees(Double(index) / Double(safeTotal) * 360),
                        endAngle: .degrees(Double(index + 1) / Double(safeTotal) * 360),
                        gap: 4
                    )
                    .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                }
                
                // Active/Completed Ring Segments
                ForEach(0..<safeCompleted, id: \.self) { index in
                    SegmentedCircle(
                        startAngle: .degrees(Double(index) / Double(safeTotal) * 360),
                        endAngle: .degrees(Double(index + 1) / Double(safeTotal) * 360),
                        gap: 4
                    )
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                }
            }
            .frame(width: 50, height: 50)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .glassEffect(in: .rect)
        .cornerRadius(24)
    }
}

struct SegmentedCircle: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var gap: Double // In degrees
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // Adjust angles to create gap
        // We convert the gap (degrees) into an adjustment for start and end
        // But a simpler way for segments is to just trim, but custom shape gives full control
        
        // Actually, let's use a simpler approach: 
        // We can just use the Arc center angles and subtract half the gap from each side.
        
        let gapAngle = Angle(degrees: gap)
        let adjustedStart = startAngle + gapAngle / 2
        let adjustedEnd = endAngle - gapAngle / 2
        
        // If the segment is too small (gap eats it all), drawing nothing is safer
        if adjustedEnd.degrees <= adjustedStart.degrees {
            return path
        }
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: adjustedStart,
            endAngle: adjustedEnd,
            clockwise: false
        )
        
        return path
    }
}

#Preview {
    ZStack {
        Color.black
        VStack(spacing: 20) {
            WeeklyProgressCard(completedWorkouts: 1, totalWorkouts: 4)
            WeeklyProgressCard(completedWorkouts: 3, totalWorkouts: 6)
            WeeklyProgressCard(completedWorkouts: 0, totalWorkouts: 3)
            WeeklyProgressCard(completedWorkouts: 5, totalWorkouts: 5)
        }
        .padding()
    }
}
