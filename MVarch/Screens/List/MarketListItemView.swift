//
//  MarketListItemView.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import SwiftUI

struct MarketListItemView: View {
    let item: MarketListItem

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                Text(item.type)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(item.price)
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
}
