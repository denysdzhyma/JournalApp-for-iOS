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
    let journal: Journal
    
    var body: some View {
        List (journal.entries) { entry in
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                Text(entry.text)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }.navigationTitle(journal.title)
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
            List(journals) { journal in
                
                NavigationLink(destination: JournalDetailView(journal: journal)) {
                    Text(journal.title)
                }
            }.navigationTitle("My Journals")
        }
    }
}

#Preview {
    ContentView()
}
