//
//  NotificationRepositorySpy.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

@testable import FoundationSummarizer

final class NotificationRepositorySpy: NotificationRepositoryProtocol {
    
    var showError: Bool = false
    
    private(set) var sendNotificationCallCount = 0
    private(set) var lastSummarySent: Summary?
    
    func requestPermission() async throws {}
    
    func sendNotification(_ summary: Summary) async throws {
        sendNotificationCallCount += 1
        lastSummarySent = summary
        if showError { throw NotificationRepositoryError.sendFailed }
    }
}
