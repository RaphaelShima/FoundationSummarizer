//
//  SummaryHistoryViewModelTest.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

import Foundation
import Testing
@testable import FoundationSummarizer

@MainActor
struct SummaryHistoryViewModelTest {
    let repositorySut = FirebaseRepositorySpy()
    let sut: SummaryHistoryViewModel
    
    init() {
        self.sut = SummaryHistoryViewModel(repository: repositorySut)
    }
    
    // MARK: - fetchSummaries
    
    @Test("fetchSummaries should update summaries with repository data")
    func test_fetchSummaries_updateSummaries() async throws {
        await sut.fetchSummaries()
        
        #expect(sut.summaries == repositorySut.summaries)
        #expect(repositorySut.fetchCallCount == 1)
    }
    
    @Test("fetchSummaries should expose error when repository throws")
    func test_fetchSummaries_fetchFails() async throws {
        repositorySut.showFetchError = true
        
        await sut.fetchSummaries()
        
        #expect(sut.summaries.isEmpty)
        #expect(sut.showError == true)
        #expect(sut.errorMessage != nil)
    }
    
    // MARK: - filterSummaries
    
    @Test("fetchSummaries should sort by newest first")
    func test_filterSummaries_newest() async throws {
        await sut.fetchSummaries()
        
        let filteredSummaries = sut.filterSummaries(.newest)
        
        #expect(filteredSummaries == filteredSummaries.sorted { $0.createdAt > $1.createdAt })
    }
    
    @Test("fetchSummaries should sort by oldest first")
    func test_filterSummaries_oldest() async throws {
        await sut.fetchSummaries()
        
        let filteredSummaries = sut.filterSummaries(.oldest)
        
        #expect(filteredSummaries == filteredSummaries.sorted { $0.createdAt < $1.createdAt })
    }
    
    // MARK: - searchSummary
    
    @Test("searchSummary should filter by title case-insensitively")
    func test_searchSummary_filtersMatchingTitle() async throws {
        await sut.fetchSummaries()
        guard let target = sut.summaries.first else {
            Issue.record("Mock não retornou summaries")
            return
        }
        sut.searchText = target.title.uppercased()
        
        let result = sut.searchSummary()
        
        #expect(result.allSatisfy {
            $0.title.localizedCaseInsensitiveContains(target.title)
        })
        #expect(result.contains { $0.id == target.id })
    }
    
    @Test("searchSummary should return empty")
    func test_searchSummary_returnsEmpty() async throws {
        await sut.fetchSummaries()
        sut.searchText = "This title doesn't exist"
        
        let searchResult = sut.searchSummary()
        
        #expect(searchResult.isEmpty)
    }
}
