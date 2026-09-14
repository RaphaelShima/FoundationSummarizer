//
//  FoundationSummarizerApp.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 11/09/26.
//

import SwiftUI

@main
struct FoundationSummarizerApp: App {
    
    @State private var service = SummarizeService()
    
    var body: some Scene {
        MenuBarExtra("", systemImage: "pencil.line") {
            SummarizerView(viewModel: SummarizerViewModel(itens: [],
                                                          service: service))
        }
    }
}
