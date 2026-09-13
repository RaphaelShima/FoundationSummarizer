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
    
    func openFinder() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.text, .pdf, .swiftSource]
    }
}
