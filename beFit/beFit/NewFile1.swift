//
//  NewFile1.swift
//  beFit
//
//  Created by Pushpank Kumar on 14/02/24.
//

import Foundation
import HealthKit

class NewFile1: ObservableObject {
    
    let healthStore = NewFile1()
    @Published var activities: [String: Activity] = [:]
    @Published var mockActivities: [String: Activity] = [
        "todaySteps": Activity(id: 0, title: "Today Steps", subtitle: "Goal: 10,000", image: "figure.walk", amount: "12,143"),
        "todayCalories": Activity(id: 1, title: "Today Calories", subtitle: "Goal: 900", image: "flame", amount: "1,241"),
    ]

    
    init() {
        let steps = HKQuantityType(.stepCount)
        let calories = HKQuantityType(.activeEnergyBurned)
        let workout = HKObjectType.workoutType()

        let healthType: Set = [steps, calories, workout]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare:[], read: healthType)
                fetchTodaySteps()
                fetchTodayCalories()
                fetchWeekRunningStatus()
            } catch {
                print("error fetching health data")
            }
        }
    }
}

extension NewFile1 {
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
             activity = Activity(id: 1, title: "Today Calories", subtitle: "Goal: 900", image: "flame", amount: calorieBurned.formattedString())
            DispatchQueue.main.async {
                self.activities["todayCalories"] = activity
            }
        }
        healthStore.execute(query)
    }
    
    func fetchWeekRunningStatus() {
        let workout = HKSampleType.workoutType()
        let timePredicate = HKQuery.predicateForSamples(withStart: .startOfWeek, end: Date())
        let workoutPredicate = HKQuery.predicateForWorkouts(with: .running)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [timePredicate, workoutPredicate])
        
        let query = HKSampleQuery(sampleType: workout, predicate: workoutPredicate, limit: 25, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                print("error")
                return
            }
            
            var count: Int = 0
            for workout in workouts {
                let duration = Int(workout.duration)/60
                count += duration
            }
            
            let activity = Activity(id: 2, title: "Running", subtitle: "Mins this week", image: "figure.walk", amount: "\(count) minutes")
            DispatchQueue.main.async {
                self.activities["weekRunning"] = activity
            }
        }
        healthStore.execute(query)
    }
}
