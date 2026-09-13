//
//  SummarizerView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import SwiftUI

struct SummarizerView: View {
    
    @State private var viewModel = SummarizerViewModel()
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.summarize()
            }, label: {
                HStack(spacing: 8) {
                    Image(systemName: "document.viewfinder.fill")
                        .font(.title)
                    
                    Text("Resumir")
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
            })
            .padding([.trailing, .leading])
            .fontWeight(.semibold)
            .buttonStyle(.glass)
            
            Text("Atalho: 􀆔􀆝R")
                .foregroundStyle(.gray)
            
            if !viewModel.itens.isEmpty {
                Divider()
                
                List(viewModel.itens) { item in
                    HStack {
                        VStack {
                            Text(item.summaryText)
                            Text(item.category.rawValue)
                        }
                    }
                }
                
               NavigationLink(destination: ItemHistoryDetailViewView()) {
                    Text("Ver histórico completo ->")
                }
            }
        }
        .frame(width: 200)
    }
}

#Preview {
    SummarizerView()
}
