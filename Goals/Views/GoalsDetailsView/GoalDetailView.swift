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

    var body: some View {
        List {
            Section(header: Text("Informacje o celu")) {
                Text(goal.goalDescription)
            }
            Section(header: Text("Poziom 1")) {
                Toggle(isOn: Binding(
                    get: { self.goal.level1Completed },
                    set: { newValue in
                        do {
                            let realm = try Realm()
                            try realm.write {
                                self.goal.level1Completed = newValue
                            }
                        } catch {
                            print("Nie udało się zaktualizować celu: \(error.localizedDescription)")
                        }
                    }
                )) {
                    Text(goal.level1)
                }
                if let date = goal.level1Date {
                    Text("Data: \(formattedDate(date))")
                }
            }
            Section(header: Text("Poziom 2")) {
                Toggle(isOn: Binding(
                    get: { self.goal.level2Completed },
                    set: { newValue in
                        do {
                            let realm = try Realm()
                            try realm.write {
                                self.goal.level2Completed = newValue
                            }
                        } catch {
                            print("Nie udało się zaktualizować celu: \(error.localizedDescription)")
                        }
                    }
                )) {
                    Text(goal.level2)
                }
                if let date = goal.level2Date {
                    Text("Data: \(formattedDate(date))")
                }
            }
            Section(header: Text("Poziom 3")) {
                Toggle(isOn: Binding(
                    get: { self.goal.level3Completed },
                    set: { newValue in
                        do {
                            let realm = try Realm()
                            try realm.write {
                                self.goal.level3Completed = newValue
                            }
                        } catch {
                            print("Nie udało się zaktualizować celu: \(error.localizedDescription)")
                        }
                    }
                )) {
                    Text(goal.level3)
                }
                if let date = goal.level3Date {
                    Text("Data realizacji: \(formattedDate(date))")
                }
            }
            if !goal.notes.isEmpty {
                Section(header: Text("Notatka")) {
                    Text(goal.notes)
                }
            }
        }
        .navigationTitle(goal.name)
        .navigationBarItems(trailing: Button("Edytuj") {
            showingEditGoal = true
        })
        .sheet(isPresented: $showingEditGoal) {
            GoalAddView(viewModel: GoalViewModel(), isEditing: true, goal: goal)
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

