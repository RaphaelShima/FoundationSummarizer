//
//  FoundationService.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 14/09/26.
//

import Foundation
import FoundationModels

protocol FoundationServiceProtocol {
    @MainActor func getResponse(fileContent: String) async throws -> LanguageModelSession.Response<FoundationResponse>
}

struct FoundationService: FoundationServiceProtocol {
    
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
