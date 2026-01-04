import SwiftUI

struct CalorieSource: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let calories: Int
    let icon: String
    let color: Color
    let time: String // e.g. "10:00 AM" or "2h ago"
}

struct StepsCaloriesCard: View {
    let steps: Int
    let totalCalories: Int
    let sources: [CalorieSource]
    
    // Only show the top 4 sources (or latest 4, depending on how array is sorted)
    private var displaySources: [CalorieSource] {
        Array(sources.prefix(4))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Top Section: Summary
            HStack(spacing: 25) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.1))
                            .frame(width: 25, height: 25)
                        
                        Image(systemName: "figure.walk")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.orange)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(steps)")
                            .font(.callout)
                            .bold()
                        
                        Text("Steps")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                // Vertical Divider
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 1, height: 40)
                
                // Calories
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.1))
                            .frame(width: 25, height: 25)
                        
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.red)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(totalCalories)")
                            .font(.callout)
                            .bold()
                        
                        Text("Kcal")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
            }
            
          
            
            // Bottom Section: Sources List
            VStack(spacing: 10) {
                HStack {
                    Text("Latest Activity")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                
                ForEach(displaySources) { source in
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(source.color.opacity(0.1))
                                .frame(width: 22, height: 22)
                            
                            Image(systemName: source.icon)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(source.color)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(source.name)
                                .font(.system(size: 12, weight: .medium))
                            
                            Text(source.time)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Text("\(source.calories) kcal")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .glassEffect(in: .rect)
        .cornerRadius(24)
    }
}

struct StepsCaloriesCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.opacity(0.1)
            StepsCaloriesCard(
                steps: 6540,
                totalCalories: 450,
                sources: [
                    CalorieSource(name: "Morning Run", calories: 320, icon: "figure.run", color: .blue, time: "8:00 AM"),
                    CalorieSource(name: "Cycling", calories: 130, icon: "bicycle", color: .green, time: "Yesterday"),
                    CalorieSource(name: "Walk", calories: 50, icon: "figure.walk", color: .orange, time: "2h ago"),
                    CalorieSource(name: "Yoga", calories: 80, icon: "figure.yoga", color: .purple, time: "Yesterday"),
                    CalorieSource(name: "Hidden", calories: 10, icon: "circle", color: .black, time: "Hidden")
                ]
            )
            .padding()
        }
    }
}
