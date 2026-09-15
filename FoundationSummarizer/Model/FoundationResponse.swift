//
//  FoundationResponse.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import Foundation
import FoundationModels

@Generable
struct FoundationResponse {
    @Guide(description: "One short title that describes the document in 3 to 5 words")
    var title: String
    
    @Guide(description: "Summarization of the main ideas in 2 to 3 sentences")
    var summary: String

    @Guide(description: "Category: Work, Personal, Study, Code or Unkownm")
    var category: String

    @Guide(description: "Specific, relevant keywords, avoiding generic terms", .count(3))
    var keywords: [String]
}
