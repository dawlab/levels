//
//  GoalAddView.swift
//  Goals
//
//  Created by Dawid Łabno on 04/06/2023.
//

import SwiftUI

struct GoalAddView: View {
    @ObservedObject var viewModel: GoalViewModel
    @State private var goalName: String = ""
    @State private var goalDescription: String = ""
    @State private var goalLevel1: String = ""
    @State private var goalLevel1Date: Date?
    @State private var goalLevel2: String = ""
    @State private var goalLevel2Date: Date?
    @State private var goalLevel3: String = ""
    @State private var goalLevel3Date: Date?
    @State private var goalCategory: String = "Zdrowie"
    @State private var goalNotes: String = ""
    @Environment(\.presentationMode) var presentationMode

    let isEditing: Bool
    let goal: Goal?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Podstawowe informacje")) {
                    TextField("Nazwa celu", text: $goalName)
                    Picker("Kategoria", selection: $goalCategory) {
                        Text("Duchowość").tag("Duchowość")
                        Text("Zdrowie").tag("Zdrowie")
                        Text("Praca").tag("Praca")
                        Text("Życie Towarzyskie").tag("Życie Towarzyskie")
                        Text("Rozwój").tag("Rozwój")
                        Text("Relaks").tag("Relaks")
                        Text("Rodzina").tag("Rodzina")
                        Text("Posiadanie").tag("Posiadanie")
                    }
                }
                
                Section(header: Text("Informacje o celu")) {
                    TextField("Szczegółowe informacje", text: $goalDescription, axis: .vertical)
                        .frame(minHeight: 80)
                        .lineLimit(5...10)
                }
                
                Section(header: Text("Poziomy i daty")) {
                    TextField("Poziom 1", text: $goalLevel1)
                    DatePicker("Data realizacji (poziom 1)", selection: Binding<Date>(
                        get: { goalLevel1Date ?? Date() },
                        set: { goalLevel1Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                    
                    TextField("Poziom 2", text: $goalLevel2)
                    DatePicker("Data realizacji (poziom 2)", selection: Binding<Date>(
                        get: { goalLevel2Date ?? Date() },
                        set: { goalLevel2Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                    
                    TextField("Poziom 3", text: $goalLevel3)
                    DatePicker("Data realizacji (poziom 3)", selection: Binding<Date>(
                        get: { goalLevel3Date ?? Date() },
                        set: { goalLevel3Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                }
                
                Section(header: Text("Notatka")) {
                    TextField("Dodaj notatkę", text: $goalNotes, axis: .vertical)
                        .frame(minHeight: 80)
                        .lineLimit(5...10)
                }
            }
            .navigationBarTitle(isEditing ? "Edytuj cel" : "Dodaj cel", displayMode: .inline)
            .navigationBarItems(trailing: Button("Zapisz") {
                saveGoal()
            })
        }
        .onAppear {
            setupData()
        }
    }
    
    private func setupData() {
        if let goal = goal {
            goalName = goal.name
            goalDescription = goal.goalDescription
            goalLevel1 = goal.level1
            goalLevel1Date = goal.level1Date
            goalLevel2 = goal.level2
            goalLevel2Date = goal.level2Date
            goalLevel3 = goal.level3
            goalLevel3Date = goal.level3Date
            goalCategory = goal.category
            goalNotes = goal.notes
        }
    }
    
    private func saveGoal() {
        if isEditing {
            guard let goal = goal else { return }
            viewModel.updateGoal(goal, name: goalName, description: goalDescription, level1: goalLevel1, level1Date: goalLevel1Date, level2: goalLevel2, level2Date: goalLevel2Date, level3: goalLevel3, level3Date: goalLevel3Date, category: goalCategory, notes: goalNotes)
        } else {
            let newGoal = Goal()
            newGoal.name = goalName
            newGoal.goalDescription = goalDescription
            newGoal.level1 = goalLevel1
            newGoal.level1Date = goalLevel1Date
            newGoal.level2 = goalLevel2
            newGoal.level2Date = goalLevel2Date
            newGoal.level3 = goalLevel3
            newGoal.level3Date = goalLevel3Date
            newGoal.category = goalCategory
            newGoal.notes = goalNotes
            viewModel.addGoal(newGoal)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
                                   

