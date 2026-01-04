import SwiftUI

struct CaloriesCard: View {
    // Data Props
    var caloriesLeft: Int
    var totalCalories: Int
    var activeCalories: Int
    var workoutCalories: Int
    
    // Derived progress (0.0 to 1.0)
    private var progress: Double {
        guard totalCalories > 0 else { return 0 }
        let consumed = totalCalories - caloriesLeft
        return Double(consumed) / Double(totalCalories)
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(caloriesLeft)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)

                Text("Calories left")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 5)
  
                HStack(spacing: 8) {
                    StatusChip(icon: "clock.arrow.circlepath", text: "+\(activeCalories)")
                    StatusChip(icon: "dumbbell.fill", text: "+\(workoutCalories)")
                }
            }
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(Color(hex: "F2F2F7"), lineWidth: 10)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(), value: progress)
                
                
                Image(systemName: "flame.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
            }
            .frame(width: 100, height: 100)
        }
        .padding(24)
        .glassEffect(in: .rect)
        .cornerRadius(24)
       
    }
}


struct StatusChip: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 10, weight: .semibold))
            Text(text)
                .font(.system(size: 12, weight: .bold))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .foregroundColor(.primary)
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
