//
//  ItemHistoryView.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 13/09/26.
//

import SwiftUI

struct SummaryHistoryView: View {
    
    @State var viewModel: SummaryHistoryViewModel
    @Environment(Router.self) private var router
    @FocusState private var isSearchFocused: Bool
    @Namespace private var filterButtonNamespace
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                if !viewModel.summaries.isEmpty {
                    if viewModel.isSearching {
                        filterButton
                            .matchedGeometryEffect(id: "filterButton", in: filterButtonNamespace)
                        
                        TextField("Buscar...", text: $viewModel.searchText)
                            .focused($isSearchFocused)
                            .textFieldStyle(.roundedBorder)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    } else {
                        Spacer()
                        
                        filterButton
                            .matchedGeometryEffect(id: "filterButton", in: filterButtonNamespace)
                    }
                    
                    Button {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            viewModel.isSearching.toggle()
                            if viewModel.isSearching {
                                isSearchFocused = true
                            } else {
                                viewModel.searchText = ""
                                isSearchFocused = false
                            }
                        }
                    } label: {
                        Image(systemName: viewModel.isSearching ? "xmark.circle.fill" : "magnifyingglass")
                    }
                }
            }
            
            List(viewModel.searchSummary()) { summary in
                Button {
                    router.push(.detail(summary))
                } label: {
                    SummaryCell(summary: summary)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .padding(4)
        .navigationTitle("Summaries")
        .toolbarVisibility(.hidden, for: .windowToolbar)
        .task {
            await viewModel.fetchSummaries()
        }
    }
    
    @ViewBuilder
    private var filterButton: some View {
        Picker("", selection: $viewModel.filterOption) {
            ForEach(FilterOption.allCases, id: \.self) { option in
                Text(option.title)
                    .tag(option)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    let fbRepositoryMock = FirebaseRepositoryMock()
    let vm = SummaryHistoryViewModel(repository: fbRepositoryMock)
    SummaryHistoryView(viewModel: vm)
        .environment(Router())
}
