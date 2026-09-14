//
//  Category.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import SwiftUI

enum Category: String {
    case code = "Code"
    case work = "Work"
    case study = "Study"
    case personal = "Personal"
    case unkown = "Unkown"
}

extension Category {
    func returnIcon() -> String {
        switch self {
        case .code:
            return "chevron.left.forwardslash.chevron.right"
        case .work:
            return "bag.fill"
        case .study:
            return "book.pages.fill"
        case .personal:
            return "person.fill"
        case .unkown:
            return ""
        }
    }
    
    func returnColor() -> Color {
        switch self {
        case .code:
            return .blue
        case .work:
            return .green
        case .study:
            return .yellow
        case .personal:
            return .black
        case .unkown:
            return .pink
        }
    }
}
