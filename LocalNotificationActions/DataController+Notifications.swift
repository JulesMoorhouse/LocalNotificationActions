//
//  DataController+Notifications.swift
//  LocalNotificationActions
//
//  Created by Jules Moorhouse on 04/06/2022.
//

import SwiftUI
import UserNotifications

extension DataController {
    func registerLocal() {
        print("INFO: registerLocal - start")

        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("INFO: Yay!")
                self.registerCategories()
            } else {
                print("INFO: Doh!")
            }
        }
        print("INFO: registerLocal - end")
    }

    func scheduleLocal() {
        print("INFO: scheduleLocal - start")

        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm"
        content.categoryIdentifier = "COLOR_ACTION"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        
        // 10:30 every morning aka repeats
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request) { (error : Error?) in
            if let theError = error {
                print("INFO: \(theError.localizedDescription)")
            }
        }
        print("INFO: scheduleLocal - end")
    }

    func registerCategories() {
        print("INFO: registerCategories - start")
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: [])
        let category = UNNotificationCategory(identifier: "COLOR_ACTION", actions: [show], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "",
                                              options: .customDismissAction)
        
        center.setNotificationCategories([category])
        print("INFO: registerCategories - end")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("INFO: userNotificationCenter.didReceive")

        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("INFO: Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // User swiped to unlock
                print("INFO: Default identifier")
            case "show":
                print("INFO: Show more information")
            default:
                break
            }
        }
        
        completionHandler()
    }
}
