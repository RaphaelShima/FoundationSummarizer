//
//  FilePanelSpy.swift
//  FoundationSummarizerTests
//
//  Created by Raphael Shimamoto on 24/09/26.
//

@testable import FoundationSummarizer
import SwiftUI

final class FilePanelSpy: FilePanelProtocol {
    var returnedUrl: URL? = URL(fileURLWithPath: "/test.swift")
    var showError = false
    var returnedFileContent = "Test file content return"
    
    private(set) var filePanelCallCount = 0
    private(set) var readFileCallCount = 0
    
    func pickFile() -> URL? {
        filePanelCallCount += 1
        return returnedUrl
    }
    
    func readFile(from url: URL) async throws -> String {
        readFileCallCount += 1
        if showError { throw FilePanelError.unsupportedFileType }
        return returnedFileContent
    }
}
