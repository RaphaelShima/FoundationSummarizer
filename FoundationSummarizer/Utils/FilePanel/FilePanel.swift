//
//  FilePanel.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 17/09/26.
//

import Foundation
import AppKit
import UniformTypeIdentifiers
import PDFKit

protocol FilePanelProtocol {
    func pickFile() -> URL?
    func readFile(from url: URL) async throws -> String
}

@MainActor
struct FilePanel: FilePanelProtocol {
    func pickFile() -> URL? {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.text, .pdf, .swiftSource]
        panel.prompt = "Choose"
        return panel.runModal() == .OK ? panel.url : nil
    }

    nonisolated func readFile(from url: URL) async throws -> String {
        guard url.startAccessingSecurityScopedResource() else {
            throw FilePanelError.accessDenied
        }
        defer { url.stopAccessingSecurityScopedResource() }

        switch url.pathExtension.lowercased() {
        case "pdf":
            return try readPDF(from: url)
        case "txt", "swift", "rtf":
            return try String(contentsOf: url, encoding: .utf8)
        default:
            throw FilePanelError.unsupportedFileType
        }
    }

    nonisolated private func readPDF(from url: URL) throws -> String {
        guard let document = PDFDocument(url: url) else {
            throw FilePanelError.failedToReadPDF
        }
        return document.string ?? ""
    }
}
