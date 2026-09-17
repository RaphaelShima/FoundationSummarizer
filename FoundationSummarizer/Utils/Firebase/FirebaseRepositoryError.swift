//
//  FirebaseRepositoryError.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 17/09/26.
//

import Foundation
 
enum FirebaseRepositoryError: Error {
    case saveFailed
    case deleteFailed
    case fetchFailed
    case invalidDocumentID
}
