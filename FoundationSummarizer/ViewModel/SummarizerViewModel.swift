//
//  SummarizerViewModel.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import Observation
import AppKit
import UniformTypeIdentifiers
import FoundationModels

protocol SummarizerViewModelProtocol {
    var itens: [SummaryItem] { get }
    var service: SummarizeServiceProtocol { get }
    
    func openFilesPanel() async
    func handleFileSelection(url: URL) async -> String
    func makeSummaryItem(foundationResponse: FoundationResponse) -> SummaryItem
}

@Observable
final class SummarizerViewModel: SummarizerViewModelProtocol {
    
    var itens: [SummaryItem] 
    var service: SummarizeServiceProtocol
    
    init(itens: [SummaryItem],
         service: SummarizeServiceProtocol) {
        self.itens = itens
        self.service = service
    }
    
    func openFilesPanel() async {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.text, .pdf, .swiftSource]
        panel.prompt = "Choose"
        
        if panel.runModal() == .OK, let url = panel.url {
            let content = await handleFileSelection(url: url)
            do {
                let response = try await service.getResponse(fileContent: content)
                let generatedResponse = response.content
                let summmaryItem = makeSummaryItem(foundationResponse: generatedResponse)
                itens.append(summmaryItem)
            } catch {
                print("Summarize error: \(error)")
            }
        }
    }
    
    func handleFileSelection(url: URL) async -> String {
        guard url.startAccessingSecurityScopedResource() else {
            print("No permission to access file: \(url)")
            return ""
        }
        defer { url.stopAccessingSecurityScopedResource() }
        
        do {
            return try String(contentsOf: url,
                                 encoding: .utf8)
        } catch {
            print("Faile to read file \(url): \(error)")
            return ""
        }
    }
    
    func makeSummaryItem(foundationResponse: FoundationResponse) -> SummaryItem {
        return SummaryItem(id: UUID(),
                           title: foundationResponse.title,
                           summaryText: foundationResponse.summary,
                           category: Category(rawValue: foundationResponse.category) ?? .unkown,
                           keywords: foundationResponse.keywords)
    }
}
