//
//  HomeView.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating:  GridItem(spacing: 20), count: 2)) {
                
                ForEach(manager.activities.sorted(by: { $0.value.id <  $1.value.id}), id: \.key) { item in
                    ActivityCardView(activity: item.value)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
