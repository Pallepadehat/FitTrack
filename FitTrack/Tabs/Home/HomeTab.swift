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
                    VStack {
                        WeekDateSelector(
                            selectedDate: $selectedDate,
                            statusForDate: { date in
                                if isFuture(date) { return .future }
                                if isCompleted(date) { return .completed }
                                return .incomplete
                            }
                        )
                        
                        TabView {
                            Tab.init() {
                                VStack {
                                    CaloriesCard(caloriesLeft: 1000, totalCalories: 2500, activeCalories: 200, workoutCalories: 76)
                                    HStack(spacing: 12) {
                                        MacroCard(
                                            title: "Protein left",
                                            value: 196,
                                            unit: "g",
                                            icon: "flame.fill", // Use appropriate SF Symbol
                                            color: .red,
                                            progress: 0.7
                                        )
                                        
                                        MacroCard(
                                            title: "Carbs left",
                                            value: 120,
                                            unit: "g",
                                            icon: "leaf.fill",
                                            color: .orange,
                                            progress: 0.4
                                        )
                                        
                                        MacroCard(
                                            title: "Fat left",
                                            value: 58,
                                            unit: "g",
                                            icon: "drop.fill",
                                            color: .blue,
                                            progress: 0.2
                                        )
                                    }
                                }
                              
                                
                                
                            }
                            
                            Tab.init() {
                                CaloriesCard(caloriesLeft: 1000, totalCalories: 2500, activeCalories: 200, workoutCalories: 76)
                            }
                         
                        }
                        .padding(.horizontal)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 400)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                    }
                    .padding(.vertical)
                }
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
        return false
    }
}

// Data Model
struct MacroItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let value: Int
    let unit: String
    let icon: String
    let color: Color
    let progress: Double
}

#Preview {
    HomeTab()
}
