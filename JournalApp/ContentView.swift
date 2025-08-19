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

struct ContentView: View {
    
    @State private var journals: [Journal] = [
        Journal(title: "Work Log", entries: []),
        Journal(title: "Personal Thoughts", entries: []),
        Journal(title: "SwiftUI Journey", entries: [])
    ]
    var body: some View {
        NavigationView {
            List(journals) { journal in
                Text(journal.title)
            }.navigationTitle("My Journals")
        }
    }
}

#Preview {
    ContentView()
}
