import Foundation
import SwiftData

@Model
class UserProfile {
    var goalWeight: Double
    var currentWeight: Double
    var height: Double
    var birthDate: Date
    var gender: String
    var dailyStepGoal: Int
    var isMetric: Bool
    
    init(
        goalWeight: Double = 70.0,
        currentWeight: Double = 75.0,
        height: Double = 175.0,
        birthDate: Date = Calendar.current.date(byAdding: .year, value: -25, to: Date())!,
        gender: String = "Not Set",
        dailyStepGoal: Int = 10000,
        isMetric: Bool = true
    ) {
        self.goalWeight = goalWeight
        self.currentWeight = currentWeight
        self.height = height
        self.birthDate = birthDate
        self.gender = gender
        self.dailyStepGoal = dailyStepGoal
        self.isMetric = isMetric
    }
}
