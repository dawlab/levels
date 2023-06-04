//
//  SettingsView.swift
//  Goals
//
//  Created by Dawid Łabno on 04/06/2023.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: InstructionsView()) {
                        HStack {
                            Image(systemName: "questionmark.circle").foregroundColor(.blue)
                            Text("How to use this app?")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AuthorView()) {
                        HStack {
                            Image(systemName: "person").foregroundColor(.blue)
                            Text("About the author")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right.fill").foregroundColor(.blue)
                        Link(destination: URL(string: "https://instagram.com/felice.app")!) {
                            Text("Instagram")
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass").foregroundColor(.blue)
                        Link(destination: URL(string: "https://zenslo.com/felice-privacy-policy/")!) {
                            Text("Privacy policy")
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                    
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass").foregroundColor(.blue)
                        Link(destination: URL(string: "https://zenslo.com/felice-terms-conditions/")!) {
                            Text("Conditions")
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

