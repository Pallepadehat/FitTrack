import SwiftUI

struct EditWeightView: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    @Binding var weight: Double
    @Binding var isMetric: Bool
    
    // Conversion factor: 1 kg = 2.20462 lbs
    var displayWeight: Binding<Double> {
        Binding {
            isMetric ? weight : weight * 2.20462
        } set: { newValue in
            weight = isMetric ? newValue : newValue / 2.20462
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Text(title)
                .font(.headline)
            
            // Toggle
            HStack(spacing: 0) {
                Text("Imperial")
                    .foregroundStyle(!isMetric ? .primary : .secondary)
                    .onTapGesture { isMetric = false }
                
                Toggle("", isOn: $isMetric)
                    .labelsHidden()
                    .padding(.horizontal)
                
                Text("Metric")
                    .foregroundStyle(isMetric ? .primary : .secondary)
                    .onTapGesture { isMetric = true }
            }
            .animation(.easeInOut, value: isMetric)
            
            VStack(spacing: 10) {
                Text(title.contains("Goal") ? "Goal Weight" : "Current Weight")
                    .font(.subheadline)
                
                HStack(spacing: 5) {
                    TextField("", value: displayWeight, format: .number.precision(.fractionLength(0...1)))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 48, weight: .bold))
                        .frame(width: 150)
                    
                    Text(isMetric ? "kg" : "lbs")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.top, 10)
                }
            }
            
            // Ruler Component
            // Dynamic range based on unit
            // KG: 30...200
            // LBS: ~66...440 (using 50...450 for clean slider)
            RulerSlider(
                value: displayWeight,
                range: isMetric ? 30...200 : 50...450
            )
            .frame(height: 100)
            .padding(.horizontal)
            // Force redraw when unit changes to reset slider internal mapping if needed
            .id(isMetric)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Save changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(30)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .padding(.top)
    }
}
