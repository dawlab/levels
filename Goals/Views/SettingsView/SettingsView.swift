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
                Section(header: Text(L10n.startHere)) {
                    NavigationLink(destination: InstructionsView()) {
                        HStack {
                            Image(systemName: "questionmark.circle").foregroundColor(.blue)
                            Text(L10n.howToUse)
                        }
                    }
                }
                
                Section(header: Text(L10n.aboutAuthor)) {
                    HStack {
                        Image("avatar")
                            .resizable()
                            .cornerRadius(50)
                            .padding(.all, 4)
                            .frame(width: 100, height: 100)
                            .background(Color.black.opacity(0.2))
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .padding(8)
                        Text(L10n.authorDesc)
                    }
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right.fill").foregroundColor(.blue)
                        Link(destination: URL(string: "https://lnk.bio/dawlab")!) {
                            Text(L10n.authorWebsite)
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                    
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right.fill").foregroundColor(.blue)
                        Link(destination: URL(string: "https://instagram.com/dwlbno")!) {
                            Text(L10n.instagram)
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                }
                
                Section(header: Text(L10n.terms)) {
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass").foregroundColor(.blue)
                        Link(destination: URL(string: "https://zenslo.com/zenslo-apps-privacy-policy/")!) {
                            Text(L10n.privacyPolicy)
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                    
                    HStack {
                        Image(systemName: "doc.text.magnifyingglass").foregroundColor(.blue)
                        Link(destination: URL(string: "https://zenslo.com/zenslo-apps-terms-of-use/")!) {
                            Text(L10n.termsService)
                        }
                        Spacer()
                        Image(systemName: "link")
                    }
                }
            }
            .navigationBarTitle(L10n.info, displayMode: .inline)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

