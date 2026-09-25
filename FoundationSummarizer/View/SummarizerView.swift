//
//  SummarizerView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 12/09/26.
//

import SwiftUI

struct SummarizerView: View {
    
    @State var viewModel: SummarizerViewModel
    @State private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
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
                        try? await viewModel.openFilesPanel()
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
                .keyboardShortcut("R", modifiers: [.command, .shift])
                         
                Text("Shortcut: 􀆔􀆝R")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                                
                if !viewModel.summaries.isEmpty {
                    
                    Divider()
                    
                    Text("Latest")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.secondary)
                    
                    ForEach(viewModel.summaries.suffix(3)) { summary in
                        Button {
                            router.push(.detail(summary))
                        } label: {
                            SummaryCell(summary: summary)
                        }
                        .buttonStyle(.borderless)
                    }
                    
                    Divider()
                    
                    Button {
                        router.push(.history)
                    } label: {
                        Text("See complete history →")
                            .font(.body.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding(16)
            .navigationDestination(for: Paths.self) { destination in
                switch destination {
                case .history:
                    SummaryHistoryView(viewModel: SummaryHistoryViewModel(repository: viewModel.firebaseRepository))
                case .detail(let summary):
                    SummaryDetailView(item: summary)
                }
            }
            .task {
                try? await viewModel.fetchSummary()
            }
            .alert("Error", isPresented: Binding(
                get: { !viewModel.errorMessage.isEmpty },
                set: { isPresented in
                    if !isPresented { viewModel.errorMessage = "" }
                }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
        .environment(router)
    }
}

//#Preview {
//    SummarizerView()
//}
