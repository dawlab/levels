//
//  NotesView.swift
//  Goals
//
//  Created by Dawid Łabno on 05/06/2023.
//

import SwiftUI
import RealmSwift

struct NotesView: View {
    @ObservedObject var goal: Goal
    @State private var showingInput = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }()

    var body: some View {
        VStack {
            List {
                ForEach(goal.notes.sorted(byKeyPath: "date", ascending: false), id: \.self) { note in
                    Section(header: Text(formattedDate(note.date))) {
                        VStack(alignment: .leading) {
                            Text(note.content)
                            note.imageData.flatMap(UIImage.init).map { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(L10n.notesSummaries)
        .navigationBarItems(trailing:
            Button(action: {
                showingInput = true
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $showingInput) {
            NoteInputView(isPresented: $showingInput) { noteText, imageData in
                addNewNote(noteText, imageData: imageData)
            }
        }
    }

    private func addNewNote(_ noteText: String, imageData: Data?) {
        let realm = try! Realm()
        try! realm.write {
            goal.notes.append(Note(content: noteText, date: Date(), imageData: imageData))
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
