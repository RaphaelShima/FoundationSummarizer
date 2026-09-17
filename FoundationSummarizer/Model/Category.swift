//
//  Category.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import SwiftUI
import FoundationModels

@Generable
enum Category: String, Codable {
    case code = "Code"
    case work = "Work"
    case study = "Study"
    case personal = "Personal"
    case unknown = "Unknown"
}

extension Category {
    var icon: String {
        switch self {
        case .code:
            "chevron.left.forwardslash.chevron.right"
        case .work:
            "bag.fill"
        case .study:
            "book.pages.fill"
        case .personal:
            "person.fill"
        case .unknown:
            ""
        }
    }

    var color: Color {
        switch self {
        case .code:
            .blue
        case .work:
            .green
        case .study:
            .yellow
        case .personal:
            .purple
        case .unknown:
            .pink
        }
    }
}
