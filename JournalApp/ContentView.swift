//
//  ContentView.swift
//  JournalApp
//
//  Created by Denys on 2025-08-18.
//

import SwiftUI

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var text: String
    let date: Date
}

struct Journal: Identifiable {
    let id = UUID()
    var title: String
    var entries: [JournalEntry]
}

struct JournalDetailView: View {
    @Binding var journal: Journal
    @State private var showingAddEntrySheet = false

    var body: some View {
        List (journal.entries) { entry in
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                Text(entry.text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(journal.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddEntrySheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddEntrySheet) {
            AddEntryView(journal: $journal)
        }
    }
}

struct AddEntryView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var journal: Journal
    @State private var newTitle = ""
    @State private var newText = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Entry Title", text: $newTitle)
                TextField("Entry Text", text: $newText, axis: .vertical)
            }
            .navigationTitle("New Journal Form")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newEntry = JournalEntry(title: newTitle, text: newText, date: Date())
                        journal.entries.append(newEntry)
                        dismiss()
                    }.disabled(newTitle.isEmpty)
                }
            }
        }
    }
}

struct ContentView: View {
    
    @State private var journals: [Journal] = [
        Journal(title: "Work Log", entries: [
            JournalEntry(title: "Met with team", text: "Discussed the new project timeline.", date: Date())
        ]),
        Journal(title: "Personal Thoughts", entries: []),
        Journal(title: "SwiftUI Journey", entries: [
            JournalEntry(title: "Learned about Lists", text: "Built a To-Do app today!", date: Date()),
            JournalEntry(title: "Started Journal App", text: "Learning about multiple data models.", date: Date())
        ])
    ]
    var body: some View {
        NavigationView {
            List($journals) { $journal in
                
                NavigationLink(destination: JournalDetailView(journal: $journal)) {
                    Text(journal.title)
                }
            }.navigationTitle("My Journals")
        }
    }
}

#Preview {
    ContentView()
}
