//
//  Router.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 21/09/26.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class Router {
    var path: [Paths] = []
    
    func push(_ pathDestination: Paths) {
        path.append(pathDestination)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
