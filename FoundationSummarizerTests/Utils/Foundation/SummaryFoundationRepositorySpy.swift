//
//  SummaryFoundationRepositorySpy.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

@testable import FoundationSummarizer

final class SummaryFoundationRepositorySpy: SummaryFoundationRepositoryProtocol {
    var returnedResponse = FoundationResponse(title: "Response Test",
                                              summary: "Test",
                                              category: .code,
                                              keywords: ["Test1", "Test2"])
    
    var showError = false
    
    private(set) var summarizeCallCount = 0
    
    func summarize(fileContent: String) async throws -> FoundationResponse {
        summarizeCallCount += 1
        if showError { throw FoundationRepositoryError.summarizationFailed }
        return returnedResponse
    }
}
