//
//  FirebaseRepositoryMock.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 23/09/26.
//

import Foundation

final class FirebaseRepositoryMock: FirebaseRepositoryProtocol {
    
    private var summaries: [Summary]
    
    init(summaries: [Summary] = SummaryMock.makeSummaries()) {
        self.summaries = summaries
    }
    
    func save(_ summary: Summary) async throws {
        summaries.append(summary)
    }
    
    func delete(_ summary: Summary) async throws {
        summaries.removeAll { $0.id == summary.id }
    }
    
    func fetch() async throws -> [Summary] {
        return summaries
    }
}
