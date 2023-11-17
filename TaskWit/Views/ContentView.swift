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
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.yellowApp)
                //.foregroundStyle(.tint)
                Text("TaskWit")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                NavigationLink {
                    TasksListsView()
                } label: {
                    Text("View Tasks")
                        .font(.title3).bold()
                        .foregroundStyle(.grayApp)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(.blackApp)
        }
    }
}

#Preview {
    ContentView()
}
