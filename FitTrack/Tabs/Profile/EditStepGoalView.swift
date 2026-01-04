import SwiftUI

struct EditStepGoalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var stepGoal: Int
    @State private var textInput: String = ""
    
    // For "Previous goal" logic, we might need to store it or just mock it if not tracked.
    // Assuming current 'stepGoal' passed in is the "previous" until saved? 
    // Or we just display the current persistence value as "Previous goal" visually?
    // Let's assume the passed binding is live, so we edit a temp state and save on Done.
    // But the design shows valid input.
    // To support "Revert", we should edit a local state and only commit on Done.
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // Header
            Text("Edit Step Goal")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            
            // Info Card
            HStack(spacing: 20) {
                // Circle Progress (Visual Only for now)
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                    Circle()
                        .trim(from: 0, to: 0.75) // Mock progress
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    
                    Image(systemName: "shoe.2.fill") // Closest to footprints
                        .font(.title2)
                        .foregroundStyle(.primary)
                }
                .frame(width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(stepGoal) steps")
                        .font(.headline)
                        .bold()
                    Text("Previous goal: \(stepGoal) steps")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .glassEffect(in: .rect) // Using app's glass effect style if available, or mimicking
            .background(Color(uiColor: .systemBackground)) // Check if glassEffect handles bg
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(16)
            
            // Input Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Step Goal")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                TextField("", text: $textInput)
                    .keyboardType(.numberPad)
                    .font(.title3)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primary, lineWidth: 1)
                    )
            }
            
            // Buttons
            HStack(spacing: 15) {
                // Revert button removed as per user request
                
                Button {
                    if let newGoal = Int(textInput) {
                        stepGoal = newGoal
                    }
                    dismiss()
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .clipShape(Capsule())
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .onAppear {
            textInput = "\(stepGoal)"
        }
        // Force the keyboard up to match screenshot behavior?
        // usually better to let user tap.
    }
}
