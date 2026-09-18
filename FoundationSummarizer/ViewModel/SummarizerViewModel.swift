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
    var notificationRepository: NotificationRepository { get }
    
    func openFilesPanel() async
    func makeSummary(foundationResponse: FoundationResponse) -> Summary
    func saveSummary(summary: Summary) async
    func deleteSummary(summary: Summary) async
}

@MainActor
@Observable
final class SummarizerViewModel: SummarizerViewModelProtocol {
    
    var summaries: [Summary] = []
    var errorMessage: String = ""
    
    let filePanel: FilePanelProtocol
    let summaryFoundationRepository: SummaryFoundationRepositoryProtocol
    let firebaseRepository: FirebaseRepositoryProtocol
    let notificationRepository: NotificationRepository
    
    init(filePanel: FilePanelProtocol,
         summaryFoundationRepository: SummaryFoundationRepositoryProtocol,
         firebaseRepository: FirebaseRepositoryProtocol,
         notificationRepository: NotificationRepository) {
        self.filePanel = filePanel
        self.summaryFoundationRepository = summaryFoundationRepository
        self.firebaseRepository = firebaseRepository
        self.notificationRepository = notificationRepository
        
        Task {
            try? await notificationRepository.requestPermission()
        }
    }
    
    func openFilesPanel() async {
        guard let fileURL = filePanel.pickFile() else { return }
        await summarizeFile(from: fileURL)
    }
    
    private func summarizeFile(from url: URL) async {
        do {
            let content = try await filePanel.readFile(from: url)
            let response = try await summaryFoundationRepository.summarize(fileContent: content)
            let summary = makeSummary(foundationResponse: response)
            await saveSummary(summary: summary)
            try await notificationRepository.sendNotification(summary)
        } catch {
            errorMessage = "Failed to summarize file."
            print("Summarize file failed: \(error)")
        }
    }
    
    func makeSummary(foundationResponse: FoundationResponse) -> Summary {
        return Summary(id: UUID(),
                       title: foundationResponse.title,
                       summaryText: foundationResponse.summary,
                       category: foundationResponse.category,
                       keywords: foundationResponse.keywords)
    }
    
    func saveSummary(summary: Summary) async {
        do {
            try await firebaseRepository.save(summary)
            summaries.append(summary)
        } catch {
            errorMessage = "Failed to save summary."
            print("Save summary failed: \(error.localizedDescription)")
        }
    }
    
    func deleteSummary(summary: Summary) async {
        do {
            try await firebaseRepository.delete(summary)
            summaries.removeAll { $0.id == summary.id }
        } catch {
            errorMessage = "Failed to delete summary."
            print("Delete summary failed: \(error.localizedDescription)")
        }
    }
    
    func fetchSummary() async {
        do {
            summaries = try await firebaseRepository.fetch()
        } catch {
            errorMessage = "Failed to fetch summaries."
            print("Fetch summaries failed: \(error.localizedDescription)")
        }
    }
}
