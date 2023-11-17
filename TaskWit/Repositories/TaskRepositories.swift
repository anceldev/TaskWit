//
//  TaskRepositories.swift
//  TaskWit
//
//  Created by Ancel Dev account on 9/11/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class TaskRepositories {
    private var db = Firestore.firestore().collection("TaskWit_v1")  // Reference to my collection.
    
    func createNewTask(_ task: TaskWit) async throws {
        let taskDocument = db.document("\(task.id)")
        do {
            try await taskDocument.setData(from: task)
        }
        catch {
            print("[TasksRepositories] Can't create task document.")
            throw TaskError.uncreated
        }
    }
    func fetchTasks() async throws -> [TaskWit]{
        let snapshot = try await db.order(by: "deadline", descending: true).getDocuments() // get documents collection ordered by timestamp.
        let tasks = snapshot.documents.compactMap { document in // Map documents (ignoring nil values) in a tasks array
            try! document.data(as: TaskWit.self) // Decode each document in a new TaskWit object
        }
        return tasks
    }
    
    
    enum TaskError: Error {
        case uncreated
        case unfetched
    }
}

private extension DocumentReference {
    func setData<T: Encodable>(from value: T) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            // Method only throws if there’s an encoding error, which indicates a problem with our model.
            // We handled this with a force try, while all other errors are passed to the completion handler.
            try! setData(from: value) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
}
