//
//  FirestoreSummaryDTO.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 17/09/26.
//

import Foundation
import FirebaseFirestore

struct FirestoreSummaryDTO: Codable {
    let title: String
    let summaryText: String
    let category: Category
    let keywords: [String]
}
