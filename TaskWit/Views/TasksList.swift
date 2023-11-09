//
//  TasksList.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import SwiftUI

struct TasksList: View {
    
    @State var viewModel = TasksViewModel()
    @State private var showNewTaskForm = false
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack{
                    if viewModel.tasks.isEmpty {
                        VStack {
                            Text("No items to display.\nPlease press \"New Task\" to add new items")
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    else {
                        List(viewModel.tasks) { task in
                            NavigationLink(task.title, value: task)
//                            ForEach(viewModel.tasks, id: \.self) { task in
//                                NavigationLink(task.title, value: task)
//                            }
                        }
                    }
                }
                .navigationDestination(for: TaskWit.self) { detailTask in
                    DetailTask(task: detailTask)
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("New Task") {
                            showNewTaskForm.toggle()
                        }
                        .padding(4)
                        .font(.body)
                        .foregroundStyle(.blackText)
                        .background(.cyanApp)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        
                    }
                }
                .background(.backgroundApp)
                .sheet(isPresented: $showNewTaskForm, content: {
                    NewTaskForm(viewModel: viewModel)
                        .navigationBarBackButtonHidden(true)
                })
            }
        }
        .onAppear {
            viewModel.loadTasks()
        }
    }
}

#Preview {
    TasksList()
}
