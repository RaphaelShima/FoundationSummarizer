//
//  FirebaseService.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 16/09/26.
//

import Foundation
import FirebaseFirestore

protocol FirebaseServiceProtocol {
    func saveSummary(summary: SummaryItem) async throws
    func fetchSummaries() async throws -> [SummaryItem]
}

struct FirebaseService: FirebaseServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func saveSummary(summary: SummaryItem) async throws {
        _ = try db.collection("summaries").addDocument(from: summary)
    }
    
    func fetchSummaries() async throws -> [SummaryItem] {
        let snapshot = try await db.collection("summaries").getDocuments()
        return try snapshot.documents.map { document in
            try document.data(as: SummaryItem.self)
        }
    }
}
