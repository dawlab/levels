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
    @State private var goalCategory: String = L10n.health
    @State private var goalNotes: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false

    let isEditing: Bool
    let goal: Goal?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(L10n.basicInfo)) {
                    TextField(L10n.goalName, text: $goalName)
                    Picker(L10n.category, selection: $goalCategory) {
                        Text(L10n.spirituality).tag(L10n.spirituality)
                        Text(L10n.health).tag(L10n.health)
                        Text(L10n.work).tag(L10n.work)
                        Text(L10n.social).tag(L10n.social)
                        Text(L10n.personalDevelopment).tag(L10n.personalDevelopment)
                        Text(L10n.relax).tag(L10n.relax)
                        Text(L10n.family).tag(L10n.family)
                        Text(L10n.assets).tag(L10n.assets)
                    }
                }
                
                Section(header: Text(L10n.aboutGoal)) {
                    TextField(L10n.goalinfo, text: $goalDescription, axis: .vertical)
                        .frame(minHeight: 80)
                        .lineLimit(5...10)
                }
                
                Section(header: Text(L10n.levelsDates)) {
                    TextField(L10n.level1, text: $goalLevel1)
                    DatePicker(L10n.completionDate, selection: Binding<Date>(
                        get: { goalLevel1Date ?? Date() },
                        set: { goalLevel1Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? L10n.en))
                    
                    TextField(L10n.level2, text: $goalLevel2)
                    DatePicker(L10n.completionDate, selection: Binding<Date>(
                        get: { goalLevel2Date ?? Date() },
                        set: { goalLevel2Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? L10n.en))
                    
                    TextField(L10n.level3, text: $goalLevel3)
                    DatePicker(L10n.completionDate, selection: Binding<Date>(
                        get: { goalLevel3Date ?? Date() },
                        set: { goalLevel3Date = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? L10n.en))
                }
            }
            .navigationBarTitle(isEditing ? L10n.editGoal : L10n.addGoal, displayMode: .inline)
            .navigationBarItems(trailing: Button(L10n.save) {
                saveGoal()
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text(L10n.error), message: Text(L10n.errorMessage), dismissButton: .default(Text(L10n.ok)))
                        }
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
        }
    }
    
    private func saveGoal() {
        guard !goalName.isEmpty,
              !goalLevel1.isEmpty,
              !goalLevel2.isEmpty,
              !goalLevel3.isEmpty,
              goalLevel1Date != nil,
              goalLevel2Date != nil,
              goalLevel3Date != nil else {
                showAlert = true
                  return
              }

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
            viewModel.addGoal(newGoal)
        }
        presentationMode.wrappedValue.dismiss()
    }
}
                                   

