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
    @State private var showingInstructions = false

    var body: some View {
        NavigationView {
            if viewModel.goals.isEmpty {
                VStack {
                    Spacer()

                    Text(L10n.welcomeMessage)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button(action: {
                        selectedGoal = nil
                        showingAddGoal = true
                    }) {
                        Text(L10n.welcomeButton)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Button(L10n.howToUse) {
                        showingInstructions = true
                    }
                    .padding()
                    .sheet(isPresented: $showingInstructions) {
                        InstructionsView()
                    }
                    Spacer()
                }
                .navigationBarTitle(L10n.goals, displayMode: .inline)
            } else {
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
                                        Text(L10n.edit)
                                        Image(systemName: "pencil")
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.removeGoals)
                }
                .navigationBarTitle(L10n.goals, displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    selectedGoal = nil
                    showingAddGoal = true
                }) {
                    Image(systemName: "plus")
                })
            }
        }
        .sheet(isPresented: $showingAddGoal) {
            GoalAddView(viewModel: viewModel, isEditing: selectedGoal != nil, goal: selectedGoal)
        }
    }
}
