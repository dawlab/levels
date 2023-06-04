//
//  GoalListView.swift
//  Goals
//
//  Created by Dawid Łabno on 03/06/2023.
//

import SwiftUI
import RealmSwift

struct GoalListView: View {
    @ObservedObject var viewModel: GoalViewModel
    @State private var showingAddGoal = false
    @State private var selectedGoal: Goal? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.groupGoalsByCategory().sorted(by: { $0.key < $1.key }), id: \.key) { category, goals in
                    Section(header: Text(category)) {
                        ForEach(goals) { goal in
                            NavigationLink(destination: GoalDetailView(goal: goal)) {
                                VStack(alignment: .leading) {
                                    Text(goal.name)
                                        .font(.headline)
                                        .strikethrough(goal.isCompleted, color: .red)
                                    
                                    ProgressView("\(goal.status)", value: goal.progress, total: 3)
                                        .progressViewStyle(DefaultProgressViewStyle())
                                }
                            }
                            .contextMenu {
                                Button(action: {
                                    selectedGoal = goal
                                    showingAddGoal = true
                                }) {
                                    Text("Edytuj")
                                    Image(systemName: "pencil")
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.removeGoals)
            }
            .navigationBarTitle("Cele", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                selectedGoal = nil
                showingAddGoal = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingAddGoal) {
            GoalAddView(viewModel: viewModel, isEditing: selectedGoal != nil, goal: selectedGoal)
        }
    }
}

