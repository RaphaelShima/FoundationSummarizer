//
//  SummaryMock.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import Foundation
import SwiftUI

struct SummaryMock {

    private static let mockCategories: [Category] = [
        .code, .personal, .study, .work, .unknown
    ]

    private static let mockTitles: [String] = [
        "Summary of the AI article",
        "Project meeting notes",
        "Key points from the book",
        "Notes from the Swift lecture",
        "Podcast highlights",
        "Quarterly report analysis",
        "Interview summary",
        "Main topics from the talk"
    ]

    private static let mockSummaryTexts: [String] = [
        "An automatically generated summary covering the main points discussed, focusing on the most relevant aspects of the original content.",
        "A concise overview of the central ideas presented, highlighting conclusions and suggested next steps.",
        "A synthesis of the topics covered, organizing the information clearly and objectively for quick reference.",
        "A compilation of the key points, including context, main arguments, and final considerations.",
        "A structured overview of the material, prioritizing the most relevant information for future reference."
    ]

    private static let mockKeywords: [String] = [
        "productivity", "technology", "innovation", "strategy", "data",
        "design", "leadership", "learning", "health", "business",
        "swift", "ios", "ai", "research", "planning"
    ]

    static func makeSummaries(count: Int = 10) -> [Summary] {
        (0..<count).map { _ in makeSummary() }
    }

    static func makeSummary() -> Summary {
        Summary(
            id: UUID(),
            title: mockTitles.randomElement()!,
            summaryText: mockSummaryTexts.randomElement()!,
            category: mockCategories.randomElement()!,
            keywords: randomKeywords(),
            createdAt: randomDate()
        )
    }

    private static func randomKeywords() -> [String] {
        let count = Int.random(in: 2...4)
        return Array(mockKeywords.shuffled().prefix(count))
    }

    private static func randomDate() -> Date {
        let daysAgo = Double.random(in: 0...60)
        let secondsAgo = daysAgo * 24 * 60 * 60
        return Date().addingTimeInterval(-secondsAgo)
    }
}
