//
//  NotificationManager.swift
//  YOUCAN
//
//  Created by Артем  on 4/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("permission: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("notification settings: \(settings)")
        }
    }
    
    func sendNotification(title: String, body: String, identifier: String, date: Date, repeats: Bool) {
        let content = UNMutableNotificationContent()
        let userAction = "User Action"
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let triggerDaily = Calendar.current.dateComponents([.month,.day,.hour,.minute], from: date)
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: repeats)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: calendarTrigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userAction,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        notificationCenter.setNotificationCategories([category])
    }
    
    func removeNotification(identifier: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifier)
        print("\(identifier) notification deleted!")
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notification with the local notification ID")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Snooze":
            print("Snooze")
            //scheduleNotification(notificationType: "Reminder")
        case "Delete":
            print("Delete")
        default:
            print("Unknown action")
        }
        
        completionHandler()
    }
}
