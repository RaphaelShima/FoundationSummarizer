//
//  SummaryItemHistoryCell.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import SwiftUI

struct SummaryItemHistoryCell: View {
    
    @State var item: SummaryItem
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(item.category.returnColor())
                    .frame(width: 24, height: 24)
                
                Image(systemName: item.category.returnIcon())
                    .font(.system(size: 8))
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                
                Text(item.category.rawValue)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    SummaryItemHistoryCell(item: SummaryItem(id: UUID(),
                                      title: "Teste1",
                                      summaryText: "",
                                      category: .code,
                                      keywords: ["Teste1"])
    )
}
