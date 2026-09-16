//
//  SummaryItem.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import FirebaseFirestore

struct SummaryItem: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var title: String
    var summaryText: String
    let category: Category
    let keywords: [String]
}
