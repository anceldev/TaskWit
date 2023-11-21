//
//  NotificationManager.swift
//  TaskWit
//
//  Created by Ancel Dev account on 20/11/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if error != nil {
                print("Error requesting authorizations")
            } else {
                print("Success requesting authorizations")
            }
        }
    }
    
    func scheduleNotification(item: TaskWit) {
        let content = UNMutableNotificationContent() // Editable content for notification
        content.title = item.title
        content.subtitle = "10 minutes left to complete the task" // Think about pick just a substring of notes. Not at all
        content.sound = .default
        content.badge = 1
        let notificationDate = item.deadline.addingTimeInterval(-600)
        
        let calendar = Calendar.current
        var notificationDateComponents = DateComponents()
        notificationDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationDateComponents, repeats: true)
        let request = UNNotificationRequest(
            identifier: item.id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
}
