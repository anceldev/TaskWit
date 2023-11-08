//
//  TasksList.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import SwiftUI

struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
            Text("Back")
        }
        .foregroundStyle(.blackText)
    }
}

struct NewTaskForm: View {
    @Bindable var viewModel: Tasks
    @Environment(\.dismiss) var dismiss
    @State var newTask = TaskWit()
    
    var customLabel: some View {
        HStack {
            Text(newTask.priority.rawValue)
                .foregroundStyle(.blackText)
                .font(.body)
        }
        .padding([.leading, .trailing], 25)
        .frame(height: 32)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.orangeApp, lineWidth: 1)
                .frame(width: 100, height: 38)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title:", text: $newTask.title)
                    .font(.title)
                    .foregroundStyle(.blackText)
                TextField("Note:", text: $newTask.notes)
                    .foregroundStyle(.blueText)
                DatePicker("Due date", selection: $newTask.deadline, in: Date()...)
                HStack {
                    /*Picker("Priority", selection: $newTask.priority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue)
                        }
                    }
                    .foregroundStyle(.orangeApp)
                    .accentColor(.orangeApp)*/
                    Spacer()
                    
                    Menu {
                        Picker("Priority", selection: $newTask.priority) {
                            ForEach(Priority.allCases, id: \.self) { priority in
                                Text(priority.rawValue)
                            }
                        }
                    } label: {
                        customLabel
                    }
                    
                }
                Button {
                    saveTask()
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Save")
                            .font(.footnote)
                    }
                    .foregroundStyle(.white)
                    .frame(width: 140)
                }
                .buttonStyle(.bordered)
                .background(.orangeApp)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                Spacer()
            }
            .padding()
            .background(.backgroundApp)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
    func saveTask() {
        if !newTask.title.isEmpty {
            viewModel.tasks.append(newTask)
        }
    }
}

#Preview {
    NewTaskForm(viewModel: Tasks())
}
