import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Account
                    ProfileSection(title: "Account") {
                        NavigationLink {
                            PersonalDetailsView()
                        } label: {
                            ProfileRow(icon: "person", title: "Personal Details")
                        }
                        .buttonStyle(.plain)
                        Divider()
                        ProfileRow(icon: "gear", title: "Preferences")
                        Divider()
                        ProfileRow(icon: "textformat", title: "Language")
                    }
                    
                    // Goals & Tracking
                    ProfileSection(title: "Goals & Tracking") {
                        ProfileRow(icon: "target", title: "Edit Nutrition Goals")
                        Divider()
                        ProfileRow(icon: "scalemass", title: "Goals and Current Weight")
                        Divider()
                        ProfileRow(icon: "bell", title: "Tracking Reminders")
                        Divider()
                        ProfileRow(icon: "chart.bar", title: "Weight History")
                        Divider()
                        ProfileRow(icon: "circle.grid.cross", title: "Ring Colors Explained")
                    }
                    
                    // Support & Legal
                    ProfileSection(title: "Support & Legal") {
                        ProfileRow(icon: "lightbulb", title: "Request a Feature")
                        Divider()
                        ProfileRow(icon: "envelope", title: "Support Email")
                        Divider()
                        ProfileRow(icon: "arrow.triangle.2.circlepath", title: "Sync Data")
                        Divider()
                        ProfileRow(icon: "doc.text", title: "Terms and Conditions")
                        Divider()
                        ProfileRow(icon: "hand.raised", title: "Privacy Policy")
                    }
                    
                    // Account Actions
                    ProfileSection(title: "Account Actions") {
                        ProfileRow(icon: "trash", title: "Delete All Data", color: .red)
                    }
                }
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProfileSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.secondary)
                .padding(.leading, 5)
            
            VStack(spacing: 0) {
                content
            }
            .padding(.vertical, 8)
            .glassEffect(in: .rect)
            .cornerRadius(16)
        }
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    var color: Color = .primary
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(color)
                .frame(width: 24)
            
            Text(title)
                .font(.body)
                .foregroundStyle(color)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding()
        .contentShape(Rectangle()) // Make wider area tappable
    }
}

#Preview {
    ProfileView()
}
