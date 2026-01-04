import SwiftUI

struct EditGenderView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var gender: String
    
    let options = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Set Gender")
                .font(.headline)
                .padding(.top)
            
            Spacer()
            
            VStack(spacing: 16) {
                ForEach(options, id: \.self) { option in
                    Button {
                        gender = option
                    } label: {
                        Text(option)
                            .font(.headline)
                            .foregroundColor(gender == option ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(gender == option ? Color.black : Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(16)
                    }
                }
            }
            .padding(.horizontal)
            
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
