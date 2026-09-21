//
//  SummaryHistoryViewModel.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 20/09/26.
//

import Foundation
import Observation

protocol SummaryHistoryViewModelProtocol {
    var summaries: [Summary] { get }
    func fetchSummaries() async
}

@Observable
final class SummaryHistoryViewModel: SummaryHistoryViewModelProtocol {
    private(set) var summaries: [Summary] = []
    
    private let repository: FirebaseRepository
    
    init(repository: FirebaseRepository) {
        self.repository = repository
    }
    
    func fetchSummaries() async {
        do {
            summaries = try await repository.fetch()
        } catch {
            print("Fetch error \(error)")
        }
    }
}

