//
//  SettingsView.swift
//  Goals
//
//  Created by Dawid Łabno on 04/06/2023.
//

import SwiftUI
import RealmSwift

struct SettingsView: View {
    @State private var isShowingPicker = false
    @State private var isShowingImporter = false
    
    private var temporaryDirectory: URL {
        FileManager.default.temporaryDirectory
    }
    
    private func exportDatabase() {
        let originalFileUrl = Realm.Configuration.defaultConfiguration.fileURL!
        let temporaryFileUrl = temporaryDirectory.appendingPathComponent(originalFileUrl.lastPathComponent)
        
        do {
            // Jeśli plik istnieje już w lokalizacji tymczasowej, usuń go.
            if FileManager.default.fileExists(atPath: temporaryFileUrl.path) {
                try FileManager.default.removeItem(at: temporaryFileUrl)
            }
            
            // Skopiuj plik do lokalizacji tymczasowej.
            try FileManager.default.copyItem(at: originalFileUrl, to: temporaryFileUrl)
            
            // Otwórz selektor plików do eksportu.
            isShowingPicker = true
        } catch {
            // Obsłuż błędy związane z operacjami na plikach.
            print("Failed to copy file: \(error)")
        }
    }
    
    @EnvironmentObject var goalViewModel: GoalViewModel
    
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
                
                Section(header: Text(L10n.levelsPremium)) {
                    HStack {
                        Image(systemName: "arrow.up.doc").foregroundColor(.blue)
                        Button(L10n.export) {
                            exportDatabase()
                        }
                        .sheet(isPresented: $isShowingPicker) {
                            DocumentPicker(url: temporaryDirectory.appendingPathComponent(Realm.Configuration.defaultConfiguration.fileURL!.lastPathComponent))
                        }
                    }
                    
                    HStack {
                        Image(systemName: "arrow.down.doc").foregroundColor(.blue)
                        Button(L10n.import) {
                            isShowingImporter = true
                        }
                        .sheet(isPresented: $isShowingImporter) {
                            DocumentImporter(url: Realm.Configuration.defaultConfiguration.fileURL!)
                                .environmentObject(goalViewModel)
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
                            Text(L10n.termsConditions)
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
            .environmentObject(GoalViewModel())
    }
}

