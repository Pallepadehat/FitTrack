//
//  HomeTab.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct HomeTab: View {
    @State private var selectedDate = Date()
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    WeekDateSelector(
                        selectedDate: $selectedDate,
                        statusForDate: { date in
                            // statusForDate logic
                            // Example:
                            if isFuture(date) { return .future }
                            if isCompleted(date) { return .completed }
                            return .incomplete
                        }
                    )
                }
                .padding()
            }
            .navigationTitle("Home")
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
    
    func isFuture(_ date: Date) -> Bool {
        return date > Date()
    }

    func isCompleted(_ date: Date) -> Bool {
        // Your logic to check if data exists for this date
        return false
    }
}

#Preview {
    HomeTab()
}
