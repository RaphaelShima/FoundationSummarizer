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
        Button {
            
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(item.category.returnColor())
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: item.category.returnIcon())
                }
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.category.rawValue)
                        .font(.subheadline)
                }
            }
            .frame(width: 200)
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
