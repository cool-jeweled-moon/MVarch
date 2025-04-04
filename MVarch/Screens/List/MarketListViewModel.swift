//
//  MarketListViewModel.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import Foundation

protocol MarketModelProtocol: Observable {
    var items: [MarketListItem] { get }
    var isLoading: Bool { get }
    var error: Error? { get }

    func observeItems() async
}

@Observable
class MarketModelMock: MarketModelProtocol {
    var items: [MarketListItem] = []
    var isLoading: Bool = false
    var error: Error?

    func observeItems() async {

    }
}

@Observable
class MarketModel: MarketModelProtocol {
    var items: [MarketListItem] = []
    var isLoading: Bool = false
    var error: Error? = nil

    private let repository: MarketRepositoryProtocol
    private let mapper: MarketListViewModelMapperProtocol

    init(
        repository: MarketRepositoryProtocol,
        mapper: MarketListViewModelMapperProtocol
    ) {
        self.repository = repository
        self.mapper = mapper
    }

    @MainActor
    func observeItems() async {
        isLoading = true
        
        for await marketItems in repository.observeItems() {
            self.items = marketItems.map { self.mapper.map(marketItem: $0) }
            if isLoading {
                isLoading = false
            }
        }
    }
}

struct MarketListItem {
    let title: String
    let type: String
    let price: String
}

protocol MarketListViewModelMapperProtocol {
    func map(marketItem: MarketItem) -> MarketListItem
}

struct MarketListViewModelMapper: MarketListViewModelMapperProtocol {
    func map(marketItem: MarketItem) -> MarketListItem {
        MarketListItem(
            title: marketItem.name,
            type: marketItem.type.rawValue,
            price: formatPrice(marketItem.price)
        )
    }

    private func formatPrice(_ price: Double) -> String {
        return String(format: "%.2f ₽", price)
    }
}
