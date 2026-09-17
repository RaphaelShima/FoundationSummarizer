//
//  SummaryDetailView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 14/09/26.
//

import SwiftUI

struct SummaryDetailView: View {
    
    let item: Summary
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
            }
            
            Tag(title: item.category.rawValue,
                textColor: item.category.color,
                backgroundColor: item.category.color)
            .padding(.top,4)
            
            Text("Summary")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.top, 4)
            
            Text(item.summaryText)
                .font(.body)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            Text("Keywords")
                .font(.caption)
                .foregroundStyle(.gray)
                .padding(.top, 4)
            
            HStack {
                ForEach(item.keywords, id: \.self) { keyword in
                    Tag(title: keyword,
                        textColor: .white)
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .toolbarVisibility(.hidden, for: .windowToolbar)
    }
}

#Preview {
    SummaryDetailView(item:
                        Summary(
                            id: UUID(),
                            title: "Teste",
                            summaryText: "Olá mundo",
                            category: .code,
                            keywords: ["Teste1",
                                       "Teste2",
                                       "Teste3"]
                        )
    )
}
