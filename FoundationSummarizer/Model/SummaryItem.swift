//
//  SummaryItem.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import SwiftData

struct SummaryItem: Identifiable, Hashable {
    let id: UUID
    var title: String
    var summaryText: String
    let category: Category
    let keywords: [String]
}
