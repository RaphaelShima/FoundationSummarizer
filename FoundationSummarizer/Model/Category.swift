//
//  Category.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import Foundation
import SwiftUI

enum Category: String {
    case code = "Código"
    case work = "Trabalho"
    case study = "Estudo"
    case personal = "Pessoal"
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
        }
    }
}
