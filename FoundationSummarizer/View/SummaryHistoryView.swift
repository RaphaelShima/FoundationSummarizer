//
//  ItemHistoryView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import SwiftUI

struct SummaryHistoryView: View {
    
    @State var viewModel: SummaryHistoryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.summaries) { summary in
                NavigationLink(value: summary) {
                    SummaryHistoryCell(summary: summary)
                }
            }
        }
        .navigationTitle("Summaries")
        .padding(16)
        .task {
            await viewModel.fetchSummaries()
        }
    }
}

//#Preview {
//    ItemHistoryView()
//}
