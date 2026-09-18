//
//  NotificationRepositoryError.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 18/09/26.
//

import Foundation

enum NotificationRepositoryError: Error {
    case permissionDenied
    case authorizationFailed
}
