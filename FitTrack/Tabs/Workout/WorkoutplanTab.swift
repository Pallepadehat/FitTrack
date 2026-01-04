//
//  WorkoutplanTab.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct WorkoutplanTab: View {
    @State private var selectedDate = Date()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
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
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Your routines")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: columns, spacing: 15) {
                            WorkoutRoutineCard(routineName: "Friday - Upper Body", exerciseCount: 5)
                            WorkoutRoutineCard(routineName: "Monday - Push", exerciseCount: 6)
                            WorkoutRoutineCard(routineName: "Wednesday - Legs", exerciseCount: 4)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
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
