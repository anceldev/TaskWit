//
//  ListView.swift
//  TaskWit
//
//  Created by Ancel Dev account on 16/11/23.
//

import SwiftUI

struct ListView: View {
    
    var viewModel: TasksViewModel
    var stateTasks: StateTask
    
    var filteredList: [TaskWit] {
        viewModel.tasks.filter { $0.state == stateTasks }
        //        TaskWit.testArray
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 1), content: {
                ForEach(filteredList, id: \.id) { item in
                    TaskRow(item: item)
                }
                
            })
            .padding(15)
        }
        .background(.blackApp)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .mask {
            Rectangle()
                .padding(.bottom, -100)
        }
    }
}

#Preview {
    ListView(viewModel: TasksViewModel(), stateTasks: StateTask.pending)
}
