//
//  BeFitTabView.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import SwiftUI

struct BeFitTabView: View {
    @EnvironmentObject var manager: HealthManager

    @State var selectedTab = "Home"
    var body: some View {
        TabView {
            HomeView()
                .tag("Home")
                .tabItem {
                    Image(systemName: "house")
                }
                .environmentObject(manager)
            ContentView()
                .tag("Person")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    BeFitTabView()
}
