//
//  SummarizerViewModelTest.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

import Testing
import SwiftUI
@testable import FoundationSummarizer

@MainActor
struct SummarizerViewModelTest {
    let filePanelSpy = FilePanelSpy()
    let summaryFoundationRepositorySpy = SummaryFoundationRepositorySpy()
    let firebaseRepositorySpy = FirebaseRepositorySpy()
    let notificationRepositorySpy = NotificationRepositorySpy()
    
    let sut: SummarizerViewModel
    
    let summary = Summary(id: UUID(),
                          title: "Test",
                          summaryText: "",
                          category: .code,
                          keywords: [],
                          createdAt: .now)
    
    init() {
        self.sut = SummarizerViewModel(filePanel: filePanelSpy,
                                       summaryFoundationRepository: summaryFoundationRepositorySpy,
                                       firebaseRepository: firebaseRepositorySpy,
                                       notificationRepository: notificationRepositorySpy)
    }
    
    // MARK: - openPanel
    
    @Test("openPanel should summarize and save a summary")
    func test_openPanel_summarizeAndSaveSumarry() async throws {
        try await sut.openFilesPanel()
        
        #expect(filePanelSpy.filePanelCallCount == 1)
        #expect(filePanelSpy.readFileCallCount == 1)
        
        #expect(summaryFoundationRepositorySpy.summarizeCallCount == 1)
        
        #expect(firebaseRepositorySpy.saveCallCount == 1)
        
        #expect(notificationRepositorySpy.sendNotificationCallCount == 1)
        
        #expect(sut.summaries.count == 1)
        #expect(sut.summaries.first?.title == "Response Test")
        
        #expect(sut.errorMessage.isEmpty)
    }
    
    @Test("openPanel should do nothing")
    func test_openPanel_selectionCancel() async throws {
        filePanelSpy.returnedUrl = nil
        
        try await sut.openFilesPanel()
        
        #expect(filePanelSpy.filePanelCallCount == 1)
        #expect(filePanelSpy.readFileCallCount == 0)
        
        #expect(summaryFoundationRepositorySpy.summarizeCallCount == 0)
        #expect(firebaseRepositorySpy.saveCallCount == 0)
        #expect(notificationRepositorySpy.sendNotificationCallCount == 0)
        
        #expect(sut.summaries.isEmpty)
    }
    
    @Test("openPanel reading file failure ")
    func test_openPanel_readingFileError() async throws {
        filePanelSpy.showError = true
        
        try await sut.openFilesPanel()
        
        #expect(filePanelSpy.filePanelCallCount == 1)
        #expect(filePanelSpy.readFileCallCount == 1)
        
        #expect(summaryFoundationRepositorySpy.summarizeCallCount == 0)
        #expect(firebaseRepositorySpy.saveCallCount == 0)
        #expect(notificationRepositorySpy.sendNotificationCallCount == 0)
        
        #expect(sut.errorMessage == "Failed to summarize file.")
    }
    
    // MARK: - makeSummary
    
    @Test("makeSummary should create a summary from the FoundationResponse")
    func test_makeSummary_createSummaryFromFoundationResponse() async throws {
        let response = FoundationResponse(
            title: "Swift",
            summary: "A summary about Swift",
            category: .code,
            keywords: ["Swift", "iOS"]
        )
        
        let result = sut.makeSummary(foundationResponse: response)
        
        #expect(result.title == "Swift")
        #expect(result.summaryText == "A summary about Swift")
        #expect(result.category == .code)
        #expect(result.keywords == ["Swift", "iOS"])
    }
    
    // MARK: - saveSummary
    
    @Test("saveSummary should add a new summary")
    func test_saveSummary_saveAndUpdateSummaries() async throws {
        try await sut.saveSummary(summary: summary)
        
        #expect(firebaseRepositorySpy.saveCallCount == 1)
        #expect(sut.summaries.contains { $0.id == summary.id })
    }
    
    @Test("saveSummary failure and should send a error message")
    func test_saveSummary_saveError() async {
        firebaseRepositorySpy.showSaveError = true
        
        await #expect(throws: FirebaseRepositoryError.saveFailed) {
            try await sut.saveSummary(summary: summary)
        }

        #expect(firebaseRepositorySpy.saveCallCount == 1)
        #expect(sut.errorMessage == "Failed to save summary.")
        #expect(sut.summaries.isEmpty)
    }
    
    // MARK: - deleteSummary
    
    @Test("deleteSummary should remove the summary")
    func test_deleteSummary_removeSummary() async throws {
        try await sut.deleteSummary(summary: summary)
        
        #expect(firebaseRepositorySpy.deleteCallCount == 1)
        #expect(sut.summaries.isEmpty)
    }
    
    @Test("deleteSummary failure and should send a error message")
    func test_deleteSummary_deleteError() async {
        firebaseRepositorySpy.showDeleteError = true
        
        sut.summaries = [summary]
        
        await #expect(throws: FirebaseRepositoryError.deleteFailed) {
            try await sut.deleteSummary(summary: summary)
        }
        
        #expect(firebaseRepositorySpy.deleteCallCount == 1)
        #expect(sut.errorMessage == "Failed to delete summary.")
        #expect(sut.summaries.count == 1)
    }
    
    // MARK: - fetchSummaries
    
    @Test("fetchSummaries should update summaries")
    func test_fetchSummaries_updateSummaries() async throws {
        let expectedSummaries = [
            Summary(
                id: UUID(),
                title: "Summary 1",
                summaryText: "Test",
                category: .code,
                keywords: ["Swift"],
                createdAt: .now
            ),
            Summary(
                id: UUID(),
                title: "Summary 2",
                summaryText: "Test",
                category: .code,
                keywords: ["iOS"],
                createdAt: .now
            )
        ]
        
        firebaseRepositorySpy.summaries = expectedSummaries
        
        try await sut.fetchSummary()
        
        #expect(firebaseRepositorySpy.fetchCallCount == 1)
        #expect(sut.summaries.count == 2)
        #expect(sut.summaries.map(\.id) == expectedSummaries.map(\.id))
    }
}
