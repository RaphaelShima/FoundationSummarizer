//
//  RouterTests.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

import SwiftUI
import Testing
@testable import FoundationSummarizer

@MainActor
struct RouterTests {
    private let router = Router()
    
    let summary = Summary(
        id: UUID(),
        title: "Test",
        summaryText: "Test",
        category: .code,
        keywords: ["Test1"],
        createdAt: .now
    )
    
    @Test("push should add new views to the navigation stack")
    func test_push_updatesNavigationStack() throws {
        #expect(router.path.isEmpty)
        
        router.push(.history)
        
        #expect(router.path.count == 1)
    }
    
    @Test("push(.detail) stores the exact Summary passed")
    func test_push_detail_storesCorrectSummary() throws {

        router.push(.detail(summary))

        guard case let .detail(pushedSummary) = router.path.last else {
            Issue.record("Expected the last path to be .detail")
            return
        }

        #expect(pushedSummary == summary)
        #expect(pushedSummary.id == summary.id)
    }
    
    @Test("pop should remove the top view from the navigation stack")
    func test_pop_removesNavigationStack() throws {
        router.push(.history)
        
        #expect(router.path.count == 1)
        
        router.pop()
        
        #expect(router.path.isEmpty)
    }
    
    @Test("popToRoot should clear the navigation stack")
    func test_popToRoot_clearsNavigationStack() throws {
        router.push(.history)
        router.push(.detail(summary))
        
        #expect(router.path.count == 2)
        
        router.popToRoot()
        
        #expect(router.path.isEmpty)
    }
}
