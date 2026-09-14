//
//  SummarizerView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import SwiftUI

struct SummarizerView: View {

    @State var viewModel: SummarizerViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "doc.text.fill")
                        .font(.headline)

                    Text("Foundation Summarizer")
                        .font(.headline)
                }
                
                Divider()
                
                Button {
                    Task {
                        await viewModel.openFilesPanel()
                    }
                } label: {
                    HStack {
                        Image(systemName: "document.viewfinder.fill")
                            .font(.headline)

                        Text("Summarize")
                            .font(.headline)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                    
                if !viewModel.itens.isEmpty {
                    
                    Divider()
                    
                    Text("Recentes")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)

                    ForEach(viewModel.itens.suffix(3)) { item in
                        SummaryItemHistoryCell(item: item)
                    }

                    Divider()

                    NavigationLink {
                        ItemHistoryView()
                    } label: {
                        Text("See complete history →")
                            .font(.body.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(16)
        }
    }
}

//#Preview {
//    SummarizerView()
//}
