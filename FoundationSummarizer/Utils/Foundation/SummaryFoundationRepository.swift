//
//  FoundationRepository.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 14/09/26.
//

import Foundation
import FoundationModels

protocol SummaryFoundationRepositoryProtocol {
    func summarize(fileContent: String) async throws -> FoundationResponse
}

struct SummaryFoundationRepository: SummaryFoundationRepositoryProtocol {
    
    let session = LanguageModelSession()
    
    func summarize(fileContent: String) async throws -> FoundationResponse {
        do {
            let response = try await session.respond(generating: FoundationResponse.self) {
                 """
                 Analyze the document below and extract the summary, category and keywords.
                 
                 Document:
                 \(fileContent)
                 """
            }
            
            return response.content
        } catch {
            throw FoundationRepositoryError.summarizationFailed
        }
    }
}
