//
//  DetailTask.swift
//  TaskWit
//
//  Created by Ancel Dev account on 9/11/23.
//

import SwiftUI

struct DetailTask: View {
    var task: TaskWit
    var body: some View {
        VStack {
            Text(task.title)
            Text(task.notes)
            Text(task.priority.rawValue)
            Text(task.state.rawValue)
        }
        .onAppear{
            print("Enter in view \(task.title)")
        }
    }
}

#Preview {
    DetailTask(task: TaskWit.test)
}
