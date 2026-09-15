//
//  Tag.swift
//  FoundationSummarizer
//
//  Created by Raphael Shimamoto on 14/09/26.
//

import SwiftUI

struct Tag: View {
    
    private let title: String
    private let textColor: Color?
    private let backgroundColor: Color?
    
    init(title: String,
         textColor: Color? = nil,
         backgroundColor: Color? = nil) {
        self.title = title
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(title)
            .font(.caption2)
            .foregroundStyle(textColor ?? .white)
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(backgroundColor ?? .black)
                    .opacity(0.3)
            }
    }
}

#Preview {
    Tag(title: "Teste",
        textColor: .green,
        backgroundColor: .green)
    .frame(maxWidth: .infinity)
}
