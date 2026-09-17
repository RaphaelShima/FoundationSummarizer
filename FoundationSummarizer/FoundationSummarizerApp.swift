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
    
    @State private var filePanel = FilePanel()
    @State private var foundationRepository: FoundationRepository
    @State private var fbRepository: FirebaseRepository
    
    init() {
        FirebaseApp.configure()
        fbRepository = FirebaseRepository()
        foundationRepository = FoundationRepository()
    }
    
    var body: some Scene {
        MenuBarExtra("Foundation Summarizer", systemImage: "pencil.line") {
            SummarizerView(viewModel: SummarizerViewModel(filePanel: filePanel,
                                                          foundationRepository: foundationRepository,
                                                          firebaseRepository: fbRepository))
        }
        .menuBarExtraStyle(.window)
    }
}
