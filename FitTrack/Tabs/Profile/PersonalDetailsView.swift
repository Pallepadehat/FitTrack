import SwiftUI
import SwiftData

struct PersonalDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userProfiles: [UserProfile]
    
    // Ensure we always have a user profile to work with
    var user: UserProfile {
        if let first = userProfiles.first {
            return first
        } else {
            let newUser = UserProfile()
            modelContext.insert(newUser)
            return newUser
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Goal Weight Card
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Goal Weight")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(formatWeight(user.goalWeight))
                                    .font(.title2)
                                    .bold()
                            }
                            Spacer()
                            NavigationLink {
                                // Navigate to Edit Goal Weight (reusing EditWeightView for now or specific)
                                EditWeightView(
                                    title: "Goal Weight",
                                    weight: Bindable(user).goalWeight,
                                    isMetric: Bindable(user).isMetric
                                )
                            } label: {
                                Text("Change Goal")
                                    .font(.caption)
                                    .bold()
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding()
                    .glassEffect(in: .rect)
                    .cornerRadius(16)
                    
                    // Details List
                    VStack(spacing: 0) {
                        DetailRow(label: "Current weight", value: formatWeight(user.currentWeight)) {
                            EditWeightView(
                                title: "Edit Weight",
                                weight: Bindable(user).currentWeight,
                                isMetric: Bindable(user).isMetric
                            )
                        }
                        Divider().padding(.leading)
                        
                        DetailRow(label: "Height", value: formatHeight(user.height)) {
                            EditHeightView(
                                height: Bindable(user).height,
                                isMetric: Bindable(user).isMetric
                            )
                        }
                        Divider().padding(.leading)
                        
                        DetailRow(label: "Date of birth", value: formatDate(user.birthDate)) {
                            EditBirthdayView(date: Bindable(user).birthDate)
                        }
                        Divider().padding(.leading)
                        
                        DetailRow(label: "Gender", value: user.gender) {
                            EditGenderView(gender: Bindable(user).gender)
                        }
                        Divider().padding(.leading)
                        
                        DetailRow(label: "Daily step goal", value: "\(user.dailyStepGoal) steps") {
                            EditStepGoalView(stepGoal: Bindable(user).dailyStepGoal)
                        }
                    }
                    .padding(.vertical, 8)
                    .glassEffect(in: .rect)
                    .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("Personal Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private func formatWeight(_ weight: Double) -> String {
        if user.isMetric {
            return String(format: "%.0f kg", weight)
        } else {
            return String(format: "%.0f lbs", weight * 2.20462)
        }
    }
    
    private func formatHeight(_ height: Double) -> String {
        if user.isMetric {
            return String(format: "%.0f cm", height)
        } else {
            return String(format: "%.0f in", height / 2.54)
        }
    }
}

struct DetailRow<Destination: View>: View {
    let label: String
    let value: String
    @ViewBuilder let destination: Destination
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack {
                Text(label)
                    .foregroundStyle(.primary)
                Spacer()
                Text(value)
                    .bold()
                    .foregroundStyle(.primary)
                Image(systemName: "pencil")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 4)
            }
            .padding()
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain) // This prevents the blue text color
    }
}
