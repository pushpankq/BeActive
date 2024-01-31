//
//  ActivityCardView.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let amount: String
}

struct ActivityCardView: View {
    @State var activity: Activity
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack(spacing: 20) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(activity.title)
                            .font(.system(size: 16))
                        
                        Text(activity.subtitle)
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }

                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundStyle(.green)
                }
                
                Text(activity.amount)
                    .font(.system(size: 24))
            }
            .padding()
        }
    }
}

#Preview { 
    ActivityCardView(activity: Activity(id: 0, title: "Daily Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "10,000"))
}

