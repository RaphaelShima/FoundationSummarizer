//
//  SummaryCell.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import SwiftUI

struct SummaryCell: View {
    
    @State var summary: Summary
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: summary.category.icon)
                .font(.system(size: 12))
                .frame(width: 24, height: 24)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(summary.category.color)
                }
            
            VStack(alignment: .leading) {
                Text(summary.title)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text(summary.category.rawValue)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(summary.createdAt, format: .relative(presentation: .named))
                .foregroundStyle(.secondary)
                .font(.caption)
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    SummaryCell(summary:
                        Summary(
                            id: UUID(),
                            title: "Teste1",
                            summaryText: "",
                            category: .code,
                            keywords: ["Teste1"],
                            createdAt: .now
                        )
    )
}
