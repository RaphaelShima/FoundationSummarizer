//
//  FirebaseRepositorySpy.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

@testable import FoundationSummarizer

final class FirebaseRepositorySpy: FirebaseRepositoryProtocol {
    var summaries: [Summary] = []
    var showSaveError = false
    var showDeleteError = false
    var showFetchError = false
    
    private(set) var saveCallCount = 0
    private(set) var deleteCallCount = 0
    private(set) var fetchCallCount = 0
    private(set) var lastSavedSummary: Summary?
    
    init(summaries: [Summary] = SummaryMock.makeSummaries()) {
        self.summaries = summaries
    }
    
    func save(_ summary: Summary) async throws {
        saveCallCount += 1
        lastSavedSummary = summary
        if showSaveError { throw FirebaseRepositoryError.saveFailed }
        summaries.append(summary)
    }
    
    func delete(_ summary: Summary) async throws {
        deleteCallCount += 1
        if showDeleteError { throw FirebaseRepositoryError.deleteFailed }
        summaries.removeAll { $0.id == summary.id }
    }
    
    func fetch() async throws -> [Summary] {
        fetchCallCount += 1
        if showFetchError { throw FirebaseRepositoryError.fetchFailed }
        return summaries
    }
}
