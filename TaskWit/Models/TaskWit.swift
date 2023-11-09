//
//  Task.swift
//  TaskWit
//
//  Created by Ancel Dev account on 8/11/23.
//

import Foundation

struct TaskWit: Codable, Identifiable, Hashable {
    var id = UUID()
    var title: String = ""
    var notes: String = ""
    var deadline = Date()
    var priority: Priority = .low
    var state: StateTask = .pending
    
}
enum Priority: String, Codable, CaseIterable{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
enum StateTask: String, Codable, CaseIterable{
    case pending = "Pending"
    case overdue = "Overdue"
    case completed = "Completed"
}
extension TaskWit {
    static var test = TaskWit(title: "First Taks", notes: "Notes for the first task of this sample app. It's just a learning project", deadline: Date(), priority: .low, state: .pending)
}
