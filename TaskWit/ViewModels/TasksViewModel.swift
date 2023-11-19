//
//  Tasks.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import Foundation
import Observation

//@MainActor
@Observable
class TasksViewModel {
    var tasks = [TaskWit]()
    
    private var tasksRepositories = TaskRepositories()
    
    func creatTask(with newTask: TaskWit) {
        tasks.append(newTask)
        Task {
            do {
                try await tasksRepositories.createNewTask(newTask)
                sortTasks()
                saveTasksLocally()
            }
            catch {
                fatalError("[TasksRepositories] Service can't create new Task. I'll be available just locally.")
            }
        }
    }
    func loadTasks() async {
        do {
            self.tasks = try await tasksRepositories.fetchTasks()
            sortTasks()
            saveTasksLocally()
        }
        catch {
            print("[TasksRepositoreis] Cant load tasks from server.")
            print("Loading tasks from local...")
            loadTasksLocally()
        }
        if !tasks.isEmpty {
            checkDates()
        }
    }
    func saveEditedTask(_ editedTask: TaskWit) async {
        if let index = tasks.firstIndex(where: { $0.id == editedTask.id }) {
            tasks[index] = editedTask
            checkDates()
            sortTasks()
            
            // Update task in firestore
            do {
                try await tasksRepositories.updateTask(editedTask)
            }
            catch {
                fatalError("ViewModel can't update document")
            }
            //
            saveTasksLocally()
        }
    }
    
    private func checkDates() {
        for item in tasks {
            if item.state != .completed {
                let indexOfItem = tasks.firstIndex(of: item)
                if item.deadline > Date() {
                    tasks[indexOfItem!].state = .pending
                } else {
                    tasks[indexOfItem!].state = .overdue
                }
            }
        }
    }
    private func sortTasks() {
        tasks = tasks.sorted(by: { $0.deadline < $1.deadline })
    }
    
    // Saves a local copy of tasks if Firestore servers in unavailable
    private func saveTasksLocally() {
        do {
            let jsonData = try JSONEncoder().encode(self.tasks)
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentsDirectory.appendingPathComponent("tasksBackup.json")
                do {
                    try jsonData.write(to: fileURL)
                }
                catch {
                    fatalError("Error writing JSON data to file: \(error)")
                }
            }
        }
        catch {
            fatalError("Error encoding JSON data: \(error)")
        }
    }
    // Loads a local copy of tasks if Firestore servers in unavailable
    private func loadTasksLocally() {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("tasksBackup.json") {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decodedTasks = try JSONDecoder().decode([TaskWit].self, from: jsonData)
                self.tasks = decodedTasks
            }
            catch {
                fatalError("Error reading JSON file: \(error.localizedDescription)")
            }
        } else {
            print("JSON file not found in the app bundle")
        }
    }
}
