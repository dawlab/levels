//
//  StatTabView.swift
//  Goals
//
//  Created by Dawid Łabno on 04/06/2023.
//

import SwiftUI

struct StartTabView: View {
    
    var body: some View {
        TabView {
            GoalListView(viewModel: GoalViewModel())
                .tabItem {
                    Image(systemName: "list.number")
                    Text(L10n.goals)
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text(L10n.info)
                }
        }
    }
}
