//
//  HealthManager.swift
//  beFit
//
//  Created by Pushpank Kumar on 31/01/24.
//

import Foundation
import HealthKit

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var activities: [String: Activity] = [:]
    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)

        let healthType: Set = [steps, calories]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare:[], read: healthType)
                fetchTodaySteps()
                fetchTodayCalories()
            } catch {
                print("error fetching health data")
            }
        }
    }
}

extension HealthManager {
    func fetchTodaySteps() {
        
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        var activity: Activity?
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { (_, result, error) in
            guard let quantity = result?.sumQuantity(), error == nil else {
                activity = Activity(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "0")
                DispatchQueue.main.async {
                    self.activities["todaySteps"] = activity
                }
                return
            }
            
            let stepCount = quantity.doubleValue(for: .count())
             activity = Activity(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchTodayCalories() {
        
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        var activity: Activity?
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { (_, result, error) in
            guard let quantity = result?.sumQuantity(), error == nil else {
                activity = Activity(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "0")
                DispatchQueue.main.async {
                    self.activities["todaySteps"] = activity
                }
                return
            }
            
            let calorieBurned = quantity.doubleValue(for: .kilocalorie())
             activity = Activity(id: 0, title: "Today Calories", subtitle: "Goal: 900", image: "flame", amount: calorieBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
}
