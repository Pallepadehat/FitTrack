import SwiftUI

struct EditHeightView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var height: Double
    @Binding var isMetric: Bool
    
    // Conversion factor: 1 cm = 0.393701 inches (1 inch = 2.54 cm)
    var displayHeight: Binding<Double> {
        Binding {
            isMetric ? height : height / 2.54
        } set: { newValue in
            height = isMetric ? newValue : newValue * 2.54
        }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Edit Height")
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
                Text("Height")
                    .font(.subheadline)
                
                HStack(spacing: 5) {
                    TextField("", value: displayHeight, format: .number.precision(.fractionLength(0...1)))
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 48, weight: .bold))
                        .frame(width: 150)
                    
                    Text(isMetric ? "cm" : "in")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.top, 10)
                }
            }
            
            // Ruler Component
            // CM: 100...250
            // IN: 39...98 (using 40...100 for clean slider)
            RulerSlider(
                value: displayHeight,
                range: isMetric ? 100...250 : 40...100
            )
            .frame(height: 100)
            .padding(.horizontal)
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
