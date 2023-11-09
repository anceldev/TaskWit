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
            }
            catch {
                fatalError("[TasksRepositories] Service can't create new Task. I'll be available just locally.")
            }
        }
    }
    func loadTasks() {
        Task {
            do {
                self.tasks = try await tasksRepositories.fetchTasks()
            }
            catch {
                fatalError("[TasksRepositoreis] Cant load tasks from server.")
            }
        }
    }
}
