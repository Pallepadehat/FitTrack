//
//  ContentView.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab.init("Home", systemImage: "house") {
                
            }
            
            Tab.init("Workout plan", systemImage: "figure.strengthtraining.traditional") {
                
            }
            
            Tab.init("Progress", systemImage: "chart.bar") {
                
            }
            
            Tab.init("Groups", systemImage: "person.3.fill") {
                
            }
        }
    }
}

#Preview {
    RootView()
}
