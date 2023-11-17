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
    
    var tasksList: [TaskWit] {
        viewModel.tasks.filter { $0.state == stateTasks }
//        TaskWit.testArray
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 1), content: {
                ForEach(tasksList, id: \.id) { item in
                    HStack {
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.title)
                                    .font(.callout)
                                    .bold()
                                    .foregroundStyle(.white)
                                Text(item.notes)
                                    .font(.caption)
                                    .foregroundStyle(.grayApp)
                                Spacer()
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("  00/00  ")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                    .padding(3)
                                    .overlay {
                                        Capsule()
                                            .stroke(stateTasks.colorState, lineWidth: 1)
                                    }
                                Spacer()
                            }
                        }
                        HStack{
                        }
                    }
                    .padding(20)
                    .background(.blackGrayApp)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
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
