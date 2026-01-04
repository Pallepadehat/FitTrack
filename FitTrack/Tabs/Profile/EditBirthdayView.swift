import SwiftUI

struct EditBirthdayView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var date: Date
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Set Birthday")
                .font(.headline)
                .padding(.top)
            
            Spacer()
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
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
    }
}
