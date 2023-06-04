//
//  Goal.swift
//  Goals
//
//  Created by Dawid Łabno on 03/06/2023.
//
import Foundation
import RealmSwift

class Goal: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var level1: String = ""
    @Persisted var level1Date: Date?
    @Persisted var level1Completed: Bool = false
    @Persisted var level2: String = ""
    @Persisted var level2Date: Date?
    @Persisted var level2Completed: Bool = false
    @Persisted var level3: String = ""
    @Persisted var level3Date: Date?
    @Persisted var level3Completed: Bool = false
    @Persisted var category: String = ""
    @Persisted var goalDescription: String = ""
    @Persisted var notes: String = ""

    var isCompleted: Bool {
        level1Completed && level2Completed && level3Completed
    }
    
    var progress: Double {
        var completedCount = 0
        if level1Completed {
            completedCount += 1
        }
        if level2Completed {
            completedCount += 1
        }
        if level3Completed {
            completedCount += 1
        }
        return Double(completedCount)
    }

    var status: String {
        if level3Completed {
            return "Cel zakończony"
        } else if level2Completed {
            return "Poziom 3 w trakcie realizacji"
        } else if level1Completed {
            return "Poziom 2 w trakcie realizacji"
        } else {
            return "Poziom 1 w trakcie realizacji"
        }
    }
}




