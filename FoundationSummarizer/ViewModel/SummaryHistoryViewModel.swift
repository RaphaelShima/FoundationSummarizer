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
    var isSearching: Bool { get set }
    var searchText: String { get set }
    var filterOption: FilterOption { get set }
    var showFilterMenu: Bool { get set}
    
    func fetchSummaries() async
    func searchSummary() -> [Summary]
}

@Observable
final class SummaryHistoryViewModel: SummaryHistoryViewModelProtocol {
    var summaries: [Summary] = []
    var isSearching: Bool = false
    var searchText: String = ""
    var filterOption: FilterOption = .newest
    var showFilterMenu: Bool = false
    
    private let repository: FirebaseRepositoryProtocol
    
    init(repository: FirebaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchSummaries() async {
        do {
            summaries = try await repository.fetch()
        } catch {
            print("Fetch error \(error)")
        }
    }
    
    func filterSummaries(_ filterOption: FilterOption) -> [Summary] {
        switch filterOption {
        case .newest:
            return summaries.sorted{ $0.createdAt > $1.createdAt }
            
        case .oldest:
            return summaries.sorted{ $0.createdAt < $1.createdAt }
        }
    }
    
    func searchSummary() -> [Summary] {
        let filteredSummaries = filterSummaries(filterOption)
        guard !searchText.isEmpty else { return filteredSummaries }
        return filteredSummaries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }
}

