//
//  NotificationDelegate.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 18/09/26.
//

import SwiftUI
import Observation
import UserNotifications

@Observable
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
