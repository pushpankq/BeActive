//
//  HomeView.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var manager: HealthManager
    let welcomeArray = ["Welcome", "Pushpank", "Kumar"]
    @State private var currentIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(welcomeArray[currentIndex])
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.secondary)
                .animation(.easeInOut(duration: 1), value: currentIndex)
                .onAppear(perform: {
                    startWelcomeTimer()
                })
            
            LazyVGrid(columns: Array(repeating:  GridItem(spacing: 20), count: 2)) {
                
                ForEach(manager.activities.sorted(by: { $0.value.id <  $1.value.id}), id: \.key) { item in
                    ActivityCardView(activity: item.value)
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func startWelcomeTimer() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            currentIndex = (currentIndex + 1 ) % welcomeArray.count
        }
    }
}

