//
//  ListView.swift
//  TaskWit
//
//  Created by Ancel Dev account on 16/11/23.
//

import SwiftUI

struct ListView: View {
    @Environment (TasksViewModel.self) var viewModel
    
//    var viewModel: TasksViewModel
    var stateTasks: StateTask
    
    var filteredList: [TaskWit] {
        viewModel.tasks.filter { $0.state == stateTasks }
        //        TaskWit.testArray
    }
    @State private var showEditForm = false
    @State var taskItem: TaskWit?
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 1), content: {
                ForEach(filteredList, id: \.id) { item in
                    TaskRow(item: item)
                }
            })
            .padding(15)
            .onChange(of: taskItem, {
                showEditForm.toggle()
            })
            .sheet(isPresented: $showEditForm, content: {
                EditFormView(taskItem: taskItem!)
                    .environment(viewModel)
            })
        }
        .background(.blackApp)
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .mask {
            Rectangle()
                .padding(.bottom, -100)
        }
    }
    
    @ViewBuilder
    func TaskRow(item: TaskWit) -> some View {
        var colorItem: Color {
            item.state.colorState
        }
        
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
                    Text(" \(item.deadline.formatted(.dateTime.day().month().year())) ")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .padding(3)
                        .overlay {
                            Capsule()
                                .stroke(colorItem, lineWidth: 1)
                        }
                    Spacer()
                    Button {
                        taskItem = item
                    } label: {
                        Image(systemName: "pencil")
                            .foregroundStyle(.grayApp)
                            .font(.title2)
                    }
                }
            }
        }
        .padding(20)
        .background(.blackGrayApp)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
//    ListView(viewModel: TasksViewModel(), stateTasks: StateTask.pending)
    ListView(stateTasks: StateTask.pending)
        .environment(TasksViewModel())
}
