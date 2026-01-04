//
//  HomeTab.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct HomeTab: View {
    @State private var selectedDate = Date()
    @State private var showProfile = false
    @State private var waterAmount: Int = 0  // Track water intake
    @State private var calorieSources: [CalorieSource] = [
        CalorieSource(
            name: "Morning Run",
            calories: 320,
            icon: "figure.run",
            color: .blue,
            time: "8:00 AM"
        ),
        CalorieSource(
            name: "Cycling",
            calories: 130,
            icon: "bicycle",
            color: .green,
            time: "Yesterday"
        ),
        CalorieSource(
            name: "Walk",
            calories: 50,
            icon: "figure.walk",
            color: .orange,
            time: "2h ago"
        ),
    
     
    ]

    var body: some View {
        NavigationStack {
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
                            Tab.init {
                                VStack {
                                    CaloriesCard(
                                        caloriesLeft: 1000,
                                        totalCalories: 2500,
                                        activeCalories: 200,
                                        workoutCalories: 76
                                    )
                                    HStack(spacing: 12) {
                                        MacroCard(
                                            title: "Protein left",
                                            value: 196,
                                            unit: "g",
                                            icon: "flame.fill",  // Use appropriate SF Symbol
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
                                    Spacer()
                                }
                            }

                            Tab.init {
                                VStack {
                                    HStack(spacing: 12) {
                                        MacroCard(
                                            title: "Protein left",
                                            value: 196,
                                            unit: "g",
                                            icon: "flame.fill",  // Use appropriate SF Symbol
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

                                    HealthScoreCard(
                                        score: 7,
                                        maxScore: 10,
                                        title: "Health Score",
                                        description:
                                            "You are well below calorie, carb, and fat goals, but need to increase protein for optimal weight loss. Great job staying on track!"
                                    )

                                    Spacer()
                                }

                            }

                            Tab.init {
                                VStack {
                                    StepsCaloriesCard(
                                        steps: 6540,
                                        totalCalories: 780,
                                        sources: calorieSources
                                    )

                                    WaterIntakeCard(
                                        amount: $waterAmount,
                                        onAdd: { waterAmount += 250 },
                                        onRemove: {
                                            waterAmount = max(
                                                0,
                                                waterAmount - 250
                                            )
                                        }
                                    )
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 350)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        
                        // Recently Uploaded Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Recently uploaded")
                                .font(.title3)
                                .bold()
                            
                            EmptyStateCard()
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)

                    }
                    .padding(.vertical)
                }
   
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showProfile.toggle()
                    } label: {
                        Image(systemName: "gearshape")
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
            .sheet(isPresented: $showProfile) {
                ProfileView()
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
