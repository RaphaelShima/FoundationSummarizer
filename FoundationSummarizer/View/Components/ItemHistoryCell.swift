//
//  SummaryHistoryCell.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import SwiftUI

struct SummaryHistoryCell: View {
    
    @State var summary: Summary
    
    var body: some View {
        HStack {
            Image(systemName: summary.category.icon)
                .font(.system(size: 16))
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(summary.category.color)
                        .frame(width: 24, height: 24)
                }
            
            VStack(alignment: .leading) {
                Text(summary.title)
                    .font(.headline)
                
                Text(summary.category.rawValue)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    SummaryHistoryCell(summary:
                            Summary(
                                id: UUID(),
                                title: "Teste1",
                                summaryText: "",
                                category: .code,
                                keywords: ["Teste1"]
                            )
    )
}
