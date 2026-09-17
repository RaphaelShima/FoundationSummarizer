//
//  FilePanelError.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 17/09/26.
//

import Foundation

enum FilePanelError: Error {
    case accessDenied
    case unsupportedFileType
    case failedToReadFile
    case failedToReadPDF
}
