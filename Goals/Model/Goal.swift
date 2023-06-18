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
    @Persisted var notes: List<Note> = List<Note>()
    @Persisted var level1Photo: Data?
    @Persisted var level2Photo: Data?
    @Persisted var level3Photo: Data?

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
            return L10n.goalCompleted
        } else if level2Completed {
            return L10n.level3InProgress
        } else if level1Completed {
            return L10n.level2InProgress
        } else {
            return L10n.level1inProgress
        }
    }
}
