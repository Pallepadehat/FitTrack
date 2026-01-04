//
//  HomeTab.swift
//  FitTrack
//
//  Created by Patrick Jakobsen on 04/01/2026.
//

import SwiftUI

struct HomeTab: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Hello world")
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
}

#Preview {
    HomeTab()
}
