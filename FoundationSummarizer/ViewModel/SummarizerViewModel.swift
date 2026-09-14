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

protocol SummarizerViewModelProtocol {
    var itens: [SummaryItem] { get }
    
    func openFilesPanel() async
    func handleFileSelection(url: URL) async -> String
}

@Observable
final class SummarizerViewModel: SummarizerViewModelProtocol {
    
    var itens: [SummaryItem] = [
//        SummaryItem(id: UUID(),
//                    summaryText: "Teste1",
//                    category: .code,
//                    keywords: ["1", "2"]),
//        SummaryItem(id: UUID(),
//                    summaryText: "Teste2",
//                    category: .code,
//                    keywords: ["2", "2"])
    ]
    
    func summarize() {
        print("Resumir")
    }
    
    func openFilesPanel() async {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.text, .pdf, .swiftSource]
        panel.prompt = "Choose"
        
        if panel.runModal() == .OK, let url = panel.url {
            let content = await handleFileSelection(url: url)
        }
    }
    
    func handleFileSelection(url: URL) async -> String {
        guard url.startAccessingSecurityScopedResource() else {
            print("No permission to access file: \(url)")
            return ""
        }
        do { url.stopAccessingSecurityScopedResource() }
        
        do {
            return try String(contentsOf: url,
                                 encoding: .utf8)
        } catch {
            print("Faile to read file \(url): \(error)")
            return ""
        }
    }
}
