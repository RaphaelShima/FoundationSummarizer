//
//  NotificationRepository.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 18/09/26.
//

import Foundation
import UserNotifications

protocol NotificationRepositoryProtocol {
    func requestPermission() async throws
    func sendNotification(_ summary: Summary) async throws
}

struct NotificationRepository: NotificationRepositoryProtocol {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestPermission() async throws {
        do {
            let authorizationGranted =  try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
            if !authorizationGranted {
                throw NotificationRepositoryError.permissionDenied
            }
        } catch {
            throw NotificationRepositoryError.authorizationFailed
        }
    }
    
    func sendNotification(_ summary: Summary) async throws {        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = summary.title
        notificationContent.body = "Your summary of \"\(summary.title)\" is ready."
        notificationContent.sound = .default
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let notificationRequest = UNNotificationRequest(
            identifier: summary.id.uuidString,
            content: notificationContent,
            trigger: notificationTrigger
        )
        
        try await notificationCenter.add(notificationRequest)
    }
}
