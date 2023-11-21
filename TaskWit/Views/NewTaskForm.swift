//
//  TasksList.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import SwiftUI
import UserNotifications

struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            Text("Back")
        }
        .foregroundStyle(.white)
    }
}

struct NewTaskForm: View {
    @Environment (TasksViewModel.self) var viewModel
    
//    @Bindable var viewModel: TasksViewModel
    @Environment(\.dismiss) var dismiss
    @State var newTask = TaskWit()
    
    var customLabel: some View {
        HStack {
            Text(newTask.priority.rawValue)
                .foregroundStyle(.white)
                .font(.body)
        }
        .padding([.leading, .trailing], 25)
        .frame(height: 32)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.yellowApp, lineWidth: 1)
                .frame(width: 100, height: 38)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Section {
                    TextField(" Title:", text: $newTask.title)
                        .padding(7)
                        .font(.title)
                        .foregroundStyle(.white)
                        .background(.blackGrayApp)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } header: {
                    Text("Task Name")
                        .foregroundStyle(.grayApp)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Section {
                    TextField("Notes:", text: $newTask.notes)
                        .padding(7)
                        .font(.body)
                        .foregroundStyle(.white)
                        .frame(height: 48)
                        .background(.blackGrayApp)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                } header: {
                    Text("Notes")
                        .foregroundStyle(.grayApp)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                DatePicker("Due date", selection: $newTask.deadline, in: Date()...)
                HStack {
                    Picker(selection: $newTask.priority) {
                        ForEach(Priority.allCases, id:\.self) { item in
                            Text(item.rawValue)
                            
                        }
                    } label: {
                        Text("Priority")
                    }
                    .pickerStyle(.segmented)
                }
                Spacer()
            }
            .padding()
            .background(.blackApp)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationTitle("Add Task")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        saveTask()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.body).bold()
                            .padding(15)
                            .foregroundStyle(.blackApp)
                            .frame(minWidth: 150)
                            .background(.yellowApp)
                            .clipShape(Capsule())
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.body).bold()
                            .padding(15)
                            .foregroundStyle(.blackApp)
                            .frame(minWidth: 150)
                            .background(.redApp)
                            .clipShape(Capsule())
                        
                    }

                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    func saveTask() {
        if !newTask.title.isEmpty {
            viewModel.createTask(with: newTask)
        }
    }
}

#Preview {
//    NewTaskForm(viewModel: TasksViewModel())
    NewTaskForm()
        .environment(TasksViewModel())
}
