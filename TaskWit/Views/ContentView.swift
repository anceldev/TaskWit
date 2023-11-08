//
//  ContentView.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "pencil.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("TaskWit")
                NavigationLink("View tasks") {
                    TasksList()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
