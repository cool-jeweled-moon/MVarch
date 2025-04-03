//
//  MarketRepository.swift
//  MVarch
//
//  Created by Борис Анели on 03.04.2025.
//

import Foundation

protocol MarketRepositoryProtocol {
    func observeItems() -> AsyncStream<[MarketItem]>
}

actor MarketRepository: MarketRepositoryProtocol {
    private var items: [MarketItem] = []
    private var continuations: [(id: UUID, continuation: AsyncStream<[MarketItem]>.Continuation)] = []


    init() {
        items = [
            MarketItem(name: "iPhone 15", price: 89990.0, type: .electronics),
            MarketItem(name: "MacBook Pro", price: 179990.0, type: .electronics),
            MarketItem(name: "Плюшевый мишка", price: 1290.0, type: .toys),
            MarketItem(name: "Конструктор", price: 3590.0, type: .toys),
            MarketItem(name: "Молоко", price: 89.90, type: .food),
            MarketItem(name: "Хлеб", price: 59.90, type: .food),
            MarketItem(name: "Диван", price: 34990.0, type: .furniture),
            MarketItem(name: "Кресло", price: 15990.0, type: .furniture)
        ]
    }

    nonisolated func observeItems() -> AsyncStream<[MarketItem]> {
            let id = UUID()
            return AsyncStream { continuation in
                Task {
                    // Используем await для доступа к actor-isolated state
                    await self.addContinuation(id: id, continuation: continuation)

                    // Получаем текущее состояние и отправляем его в continuation
                    let currentItems = await self.items
                    continuation.yield(currentItems)
                }

                continuation.onTermination = { [weak self] _ in
                    guard let self = self else { return }
                    Task {
                        // Используем await для изменения actor-isolated state
                        await self.removeContinuation(id: id)
                    }
                }
            }
        }

    // Actor-isolated метод для добавления continuation
    private func addContinuation(id: UUID, continuation: AsyncStream<[MarketItem]>.Continuation) {
        continuations.append((id: id, continuation: continuation))
    }

    // Actor-isolated метод для удаления continuation
    private func removeContinuation(id: UUID) {
        continuations.removeAll { $0.id == id }
    }


    func addItem(_ item: MarketItem) async {
        items.append(item)
        for continuation in continuations {
            continuation.continuation.yield(items)
        }
    }

    func searchItems(query: String) async throws -> [MarketItem] {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунды

        if query.isEmpty {
            return items
        }

        return items.filter { item in
            item.name.lowercased().contains(query.lowercased())
        }
    }

    func getItemsByType(_ type: MarketItemType) async throws -> [MarketItem] {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунды

        return items.filter { item in
            item.type == type
        }
    }
}

struct MarketItem: Hashable {
    let name: String
    let price: Double
    let type: MarketItemType
}

enum MarketItemType: String, Hashable {
    case electronics
    case toys
    case food
    case furniture
}

enum MarketError: Error {
    case networkError
    case itemNotFound
    case invalidData
}
