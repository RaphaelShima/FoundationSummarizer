//
//  SummarizerViewModel.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import Observation
import FoundationModels

protocol SummarizerViewModelProtocol {
    var summaries: [Summary] { get }
    var errorMessage: String { get set }
    
    var filePanel: FilePanelProtocol { get }
    var summaryFoundationRepository: SummaryFoundationRepositoryProtocol { get }
    var firebaseRepository: FirebaseRepositoryProtocol { get }
    var notificationRepository: NotificationRepositoryProtocol { get }
    
    func openFilesPanel() async throws
    func makeSummary(foundationResponse: FoundationResponse) -> Summary
    func saveSummary(summary: Summary) async throws
    func deleteSummary(summary: Summary) async throws
    func fetchSummary() async throws
}

@MainActor
@Observable
final class SummarizerViewModel: SummarizerViewModelProtocol {
    
    var summaries: [Summary] = []
    var errorMessage: String = ""
    
    let filePanel: FilePanelProtocol
    let summaryFoundationRepository: SummaryFoundationRepositoryProtocol
    let firebaseRepository: FirebaseRepositoryProtocol
    let notificationRepository: NotificationRepositoryProtocol
    
    init(filePanel: FilePanelProtocol,
         summaryFoundationRepository: SummaryFoundationRepositoryProtocol,
         firebaseRepository: FirebaseRepositoryProtocol,
         notificationRepository: NotificationRepositoryProtocol) {
        self.filePanel = filePanel
        self.summaryFoundationRepository = summaryFoundationRepository
        self.firebaseRepository = firebaseRepository
        self.notificationRepository = notificationRepository
        
        Task {
            try? await notificationRepository.requestPermission()
        }
    }
    
    func openFilesPanel() async throws {
        guard let fileURL = filePanel.pickFile() else { return }
        try await summarizeFile(from: fileURL)
    }
    
    private func summarizeFile(from url: URL) async throws {
        let content = try await filePanel.readFile(from: url)
        
        let response = try await summaryFoundationRepository.summarize(fileContent: content)
        
        let summary = makeSummary(foundationResponse: response)
        
        try await saveSummary(summary: summary)
        
        do {
            try await notificationRepository.sendNotification(summary)
        } catch {
            errorMessage = "Failed to send notification."
            throw error
        }
    }
    
    func makeSummary(foundationResponse: FoundationResponse) -> Summary {
        return Summary(id: UUID(),
                       title: foundationResponse.title,
                       summaryText: foundationResponse.summary,
                       category: foundationResponse.category,
                       keywords: foundationResponse.keywords,
                       createdAt: .now)
    }
    
    func saveSummary(summary: Summary) async throws {
        do {
            try await firebaseRepository.save(summary)
            summaries.append(summary)
        } catch {
            errorMessage = "Failed to save summary."
            throw error
        }
    }
    
    func deleteSummary(summary: Summary) async throws {
        do {
            try await firebaseRepository.delete(summary)
            summaries.removeAll { $0.id == summary.id }
        } catch {
            errorMessage = "Failed to delete summary."
            throw error
        }
    }
    
    func fetchSummary() async throws {
        do {
            summaries = try await firebaseRepository.fetch()
        } catch {
            errorMessage = "Failed to fetch summaries."
            throw error
        }
    }
}
