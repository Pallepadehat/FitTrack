//
//  FitTrackApp.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI
import SwiftData

@main
struct FitTrackApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: UserProfile.self)
    }
}
