//
//  beFitApp.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import SwiftUI

@main
struct beFitApp: App {
    @StateObject var manager = HealthManager()
    
    var body: some Scene {
        WindowGroup {
            BeFitTabView()
                .environmentObject(manager)
        }
    }
}
