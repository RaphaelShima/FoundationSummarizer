//
//  FirebaseRepository.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 16/09/26.
//

import Foundation
import FirebaseFirestore

protocol FirebaseRepositoryProtocol {
    func save(_ summary: Summary) async throws
    func delete(_ summary: Summary) async throws
    func fetch() async throws -> [Summary]
}

struct FirebaseRepository: FirebaseRepositoryProtocol {
    
    private let db = Firestore.firestore()
    
    func save(_ summary: Summary) async throws {
        let dto = FirestoreSummaryDTO(
            title: summary.title,
            summaryText: summary.summaryText,
            category: summary.category,
            keywords: summary.keywords
        )

        do {
            try db
                .collection("summaries")
                .document(summary.id.uuidString)
                .setData(from: dto)
        } catch {
            throw FirebaseRepositoryError.saveFailed
        }
    }
    
    func delete(_ summary: Summary) async throws {
        do {
            try await db
                .collection("summaries")
                .document(summary.id.uuidString)
                .delete()
        } catch {
            throw FirebaseRepositoryError.deleteFailed
        }
    }
    
    func fetch() async throws -> [Summary] {
        let snapshot = try await db
            .collection("summaries")
            .getDocuments()
        
        
        return try snapshot.documents.map { document in
            let dto = try document.data(
                as: FirestoreSummaryDTO.self
            )
            
            guard let id = UUID(uuidString: document.documentID) else {
                throw FirebaseRepositoryError.invalidDocumentID
            }
            
            return Summary(
                id: id,
                title: dto.title,
                summaryText: dto.summaryText,
                category: dto.category,
                keywords: dto.keywords
            )
        }
    }
    
}
