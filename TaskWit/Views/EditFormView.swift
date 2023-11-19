//
//  EditFormView.swift
//  TaskWit
//
//  Created by Ancel Dev account on 17/11/23.
//

import SwiftUI

struct EditFormView: View {
    @Environment (TasksViewModel.self) var viewModel
    @Environment(\.dismiss) private var dismiss
    @State var taskItem: TaskWit
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    TextField(taskItem.title, text: $taskItem.title)
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
                    TextField(taskItem.notes, text: $taskItem.notes)
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
//                DatePicker("Due date", selection: $taskItem.deadline, in: Date()...)
                HStack {
                    Picker(selection: $taskItem.priority) {
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
                        Task {
                            await viewModel.saveEditedTask(taskItem)
                        }
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
}

#Preview {
//    EditFormView(item: TaskWit.test)
    EditFormView(taskItem: TaskWit.test)
        .environment(TasksViewModel())

}
