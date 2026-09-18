//
//  FoundationSummarizerApp.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 11/09/26.
//

import SwiftUI
import FirebaseCore
import UserNotifications

@main
struct FoundationSummarizerApp: App {
    
    @State private var filePanel = FilePanel()
    @State private var summaryFoundationRepository: SummaryFoundationRepository
    @State private var fireBaseRepository: FirebaseRepository
    @State private var notificationRepository: NotificationRepository
    @State private var viewModel: SummarizerViewModel
    
    let notificationDelegate = NotificationDelegate()
    
    init() {
        FirebaseApp.configure()
        let firebaseRepository = FirebaseRepository()
               let summaryFoundationRepository = SummaryFoundationRepository()
               let notificationRepository = NotificationRepository()

               self.fireBaseRepository = firebaseRepository
               self.summaryFoundationRepository = summaryFoundationRepository
               self.notificationRepository = notificationRepository

               self.viewModel = SummarizerViewModel(
                   filePanel: FilePanel(),
                   summaryFoundationRepository: summaryFoundationRepository,
                   firebaseRepository: firebaseRepository,
                   notificationRepository: notificationRepository
               )
        
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    
    var body: some Scene {
        MenuBarExtra("Foundation Summarizer", systemImage: "pencil.line") {
            SummarizerView(viewModel: viewModel)
        }
        .menuBarExtraStyle(.window)
    }
}
