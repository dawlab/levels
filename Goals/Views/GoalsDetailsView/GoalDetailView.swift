//
//  GoalDetailView.swift
//  Goals
//
//  Created by Dawid Łabno on 03/06/2023.
//

import SwiftUI
import RealmSwift

struct GoalDetailView: View {
    @ObservedObject var goal: Goal
    @State private var showingEditGoal = false
    @State private var isGoalDeleted = false
    
    var body: some View {
        if isGoalDeleted {
            Text(L10n.goalDeleted)
        } else {
            List {
                if !goal.goalDescription.isEmpty {
                    Section(header: Text(L10n.aboutGoal)) {
                        Text(goal.goalDescription)
                            .listRowBackground(Color.clear)
                    }
                }
                Section(header: Text(L10n.level1)) {
                    Toggle(isOn: Binding(
                        get: { self.goal.level1Completed },
                        set: { newValue in
                            do {
                                let realm = try Realm()
                                try realm.write {
                                    self.goal.level1Completed = newValue
                                }
                            } catch {
                                print("Failed to update goal: \(error.localizedDescription)")
                            }
                        }
                    )) {
                        Text(goal.level1)
                    }
                    if let date = goal.level1Date {
                        HStack {
                            Text(L10n.completionDate)
                            Text("\(formattedDate(date))")
                        }
                    }
                }
                Section(header: Text(L10n.level2)) {
                    Toggle(isOn: Binding(
                        get: { self.goal.level2Completed },
                        set: { newValue in
                            do {
                                let realm = try Realm()
                                try realm.write {
                                    self.goal.level2Completed = newValue
                                }
                            } catch {
                                print("Failed to update goal: \(error.localizedDescription)")
                            }
                        }
                    )) {
                        Text(goal.level2)
                    }
                    if let date = goal.level2Date {
                        HStack {
                            Text(L10n.completionDate)
                            Text("\(formattedDate(date))")
                        }
                    }
                }
                Section(header: Text(L10n.level3)) {
                    Toggle(isOn: Binding(
                        get: { self.goal.level3Completed },
                        set: { newValue in
                            do {
                                let realm = try Realm()
                                try realm.write {
                                    self.goal.level3Completed = newValue
                                }
                            } catch {
                                print("Failed to update goal: \(error.localizedDescription)")
                            }
                        }
                    )) {
                        Text(goal.level3)
                    }
                    if let date = goal.level3Date {
                        HStack {
                            Text(L10n.completionDate)
                            Text("\(formattedDate(date))")
                        }
                    }
                }

                Section {
                    NavigationLink(destination: NotesView(goal: goal)) {
                        Text(L10n.notesSummaries)
                    }
                }
            }
            .navigationBarTitle(Text(goal.name)) // Używamy navigationBarTitle zamiast navigationTitle
            .navigationBarItems(trailing: Button(action: {
                showingEditGoal = true
            }) {
                Text(L10n.edit)
            })
            .onReceive(goal.objectWillChange) {
                if goal.isInvalidated {
                    self.isGoalDeleted = true
                }
            }
            .sheet(isPresented: $showingEditGoal) {
                if !isGoalDeleted {
                    GoalAddView(viewModel: GoalViewModel(), isEditing: true, goal: goal)
                }
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let preferredLanguage = Locale.preferredLanguages.first ?? ""
        let locale = Locale(identifier: preferredLanguage)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = locale
        
        return formatter.string(from: date)
    }
}

