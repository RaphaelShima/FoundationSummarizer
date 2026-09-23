//
//  FilterOption.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 22/09/26.
//

import Foundation

enum FilterOption: CaseIterable {
    case newest
    case oldest
    
    var title: String {
        switch self {
        case .newest: "Newest"
        case .oldest: "Oldest"
        }
    }
    
    var systemImage: String {
        switch self {
        case .newest: "arrow.down"
        case .oldest: "arrow.up"
        }
    }
}
