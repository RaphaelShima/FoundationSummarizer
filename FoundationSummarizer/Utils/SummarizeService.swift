//
//  SummarizeService.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 14/09/26.
//

import Foundation
import FoundationModels

protocol SummarizeServiceProtocol {
    @MainActor func getResponse(fileContent: String) async throws -> LanguageModelSession.Response<FoundationResponse>
}

struct SummarizeService: SummarizeServiceProtocol {
    
    let session = LanguageModelSession()
    
    func getResponse(fileContent: String) async throws -> LanguageModelSession.Response<FoundationResponse> {
        try await session.respond(generating: FoundationResponse.self) {
             """
             Analyze the document below and extract the summary, category and keywords.
             
             Document:
             \(fileContent)
             """
        }
    }
}
