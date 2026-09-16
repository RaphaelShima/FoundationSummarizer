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
    var foundationService: FoundationServiceProtocol { get }
    var firebaseService: FirebaseServiceProtocol { get }
    
    func openFilesPanel() async
    func handleFileSelection(url: URL) async -> String
    func makeSummary(foundationResponse: FoundationResponse) -> SummaryItem
    func saveSummary(summary: SummaryItem) async
}

@MainActor
@Observable
final class SummarizerViewModel: SummarizerViewModelProtocol {
    
    var itens: [SummaryItem] = []
    let foundationService: FoundationServiceProtocol
    let firebaseService: FirebaseServiceProtocol
    
    init(foundationService: FoundationServiceProtocol,
         firebaseService: FirebaseServiceProtocol) {
        self.foundationService = foundationService
        self.firebaseService = firebaseService
    }
    
    func openFilesPanel() async {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.text, .pdf, .swiftSource]
        panel.prompt = "Choose"
        
        if panel.runModal() == .OK, let url = panel.url {
            let content = await handleFileSelection(url: url)
            do {
                let response = try await foundationService.getResponse(fileContent: content)
                let generatedResponse = response.content
                let summmary = makeSummary(foundationResponse: generatedResponse)
                await saveSummary(summary: summmary)
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
    
    func makeSummary(foundationResponse: FoundationResponse) -> SummaryItem {
        return SummaryItem(title: foundationResponse.title,
                           summaryText: foundationResponse.summary,
                           category: Category(rawValue: foundationResponse.category) ?? .unkown,
                           keywords: foundationResponse.keywords)
    }
    
    func saveSummary(summary: SummaryItem) async {
        do {
            try await firebaseService.saveSummary(summary: summary)
            itens.append(summary)
        } catch {
            print("Save summary failed: \(error)")
        }
    }
    
    func fetchSummary() async {
        do {
            itens = try await firebaseService.fetchSummaries()
        } catch {
            print("Fetch summaries failed: \(error)")
        }
    }
}
