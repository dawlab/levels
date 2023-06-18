//
//  GoalViewModel.swift
//  Goals
//
//  Created by Dawid Łabno on 03/06/2023.
//
import Foundation
import Combine
import RealmSwift

class GoalViewModel: ObservableObject {
    @Published var goals: Results<Goal>
    @Published var newGoalName = ""
    @Published var newGoalLevel1 = ""
    @Published var newGoalLevel1Date: Date?
    @Published var newGoalLevel2 = ""
    @Published var newGoalLevel2Date: Date?
    @Published var newGoalLevel3 = ""
    @Published var newGoalLevel3Date: Date?
    @Published var newGoalCategory = ""
    @Published var newGoalDescription = ""
    @Published var newGoalNotes = "" // Nowe pole przechowujące notatki
    private var cancellables = Set<AnyCancellable>()
    private var notificationToken: NotificationToken?

    init() {
        let realm = try! Realm()
        goals = realm.objects(Goal.self)
        notificationToken = goals.observe { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    deinit {
        notificationToken?.invalidate()
    }
    
    func addGoal(_ goal: Goal) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(goal)
        }
    }

    func removeGoals(at offsets: IndexSet) {
        let realm = try! Realm()

        // Convert the index set to an array of goals
        let goalsToDelete = offsets.map { goals[$0] }

        // Store the objects' IDs
        let idsToDelete = goalsToDelete.map { $0.id }
        
        // Find the objects in the database again before deleting
        let objectsToDelete = idsToDelete.compactMap { realm.object(ofType: Goal.self, forPrimaryKey: $0) }

        try! realm.write {
            realm.delete(objectsToDelete)
        }

        // After deletion, make sure to update the 'goals' property
        goals = realm.objects(Goal.self)
    }

    
    func updateGoal(_ goal: Goal, name: String, description: String, level1: String, level1Date: Date?, level2: String, level2Date: Date?, level3: String, level3Date: Date?, category: String, notes: String) {
        let realm = try! Realm()
        try! realm.write {
            goal.name = name
            goal.goalDescription = description
            goal.level1 = level1
            goal.level1Date = level1Date
            goal.level2 = level2
            goal.level2Date = level2Date
            goal.level3 = level3
            goal.level3Date = level3Date
            goal.category = category
        }
    }
    
    func groupGoalsByCategory() -> [String: [Goal]] {
        let groupedGoals = Dictionary(grouping: goals) { $0.category }
        return groupedGoals
    }
}








