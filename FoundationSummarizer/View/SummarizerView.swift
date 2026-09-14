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
            VStack {
                Button(action: {
                    Task {
                        await viewModel.openFilesPanel()
                    }
                }, label: {
                    HStack(spacing: 8) {
                        Image(systemName: "document.viewfinder.fill")
                            .font(.title)
                        
                        Text("Summarize")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity)
                })
                .padding([.trailing, .leading])
                .fontWeight(.semibold)
                .buttonStyle(.glass)
                
                Text("Shortcut: 􀆔􀆝R")
                    .foregroundStyle(.gray)
                
                if !viewModel.itens.isEmpty {
                    Divider()
                    
                    Text("Recentes")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    
                    ForEach(viewModel.itens.suffix(3)) { item in
                        SummaryItemHistoryCell(item: item)
                    }
                    
                    Divider()
                    
                    NavigationLink(destination: ItemHistoryView()) {
                        Text("See complete history ->")
                    }
                }
            }
            .frame(width: 200)
        }
    }
}

//#Preview {
//    SummarizerView()
//}
