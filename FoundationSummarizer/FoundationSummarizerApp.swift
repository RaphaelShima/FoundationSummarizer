//
//  FoundationSummarizerApp.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 11/09/26.
//

import SwiftUI
import FirebaseCore

@main
struct FoundationSummarizerApp: App {
    
    @State private var foundationService = FoundationService()
    @State private var fbService: FirebaseService
    
    init() {
        FirebaseApp.configure()
        fbService = FirebaseService()
    }
    
    var body: some Scene {
        MenuBarExtra("Foundation Summarizer", systemImage: "pencil.line") {
            SummarizerView(viewModel: SummarizerViewModel(foundationService: foundationService,
                                                          firebaseService: fbService))
        }
        .menuBarExtraStyle(.window)
    }
}
