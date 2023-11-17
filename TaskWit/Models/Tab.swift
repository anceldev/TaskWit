//
//  Tab.swift
//  TaskWit
//
//  Created by Ancel Dev account on 11/11/23.
//
import SwiftUI
import Foundation

enum Tab: String, CaseIterable {
    case todo = "To Do"
    case overdue = "Overdue"
    case completed = "Completed"
    
    var systemImage: String {
        switch self {
        case .todo:
            return ""
        case .overdue:
            return ""
        case .completed:
            return ""
        }
    }
    var colorTab: Color {
        switch self {
        case .todo:
            Color.greenApp
        case .overdue:
            Color.yellowApp
        case .completed:
            Color.blueApp
        }
    }
}
