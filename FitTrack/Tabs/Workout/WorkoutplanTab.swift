//
//  WorkoutplanTab.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct WorkoutplanTab: View {
    @State private var selectedDate = Date()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    WeekDateSelector(
                        selectedDate: $selectedDate,
                        statusForDate: { date in
                            return .incomplete
                        }
                    )
                }
            }
            .navigationTitle("Workout Plans")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {

                    } label: {
                        Image(systemName: "person.circle")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 5) {
                        Image(systemName: "flame.fill")
                            .font(.caption)
                            .foregroundStyle(.orange)

                        Text("1")
                            .bold()
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    WorkoutplanTab()
}
