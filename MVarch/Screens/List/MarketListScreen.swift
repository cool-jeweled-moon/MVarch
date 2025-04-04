//
//  MarketListScreen.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import SwiftUI

struct MarketListScreen: View {

    @Environment(\.marketModel)
    private var viewModel

    var body: some View {
        List {
            ForEach(viewModel.items, id: \.title) { item in
                MarketListItemView(item: item)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Market")
        .task {
            await viewModel.observeItems()
        }
    }
}
