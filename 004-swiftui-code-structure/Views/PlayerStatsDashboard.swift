//
//  PlayerStatsDashboard.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI
import Combine


// MARK: Interface
struct PlayerStatsDashboard {
    
    @ObservedObject var viewModel: PlayerStatsDashboard.ViewModel
    @State private var isLoading: Bool = false

}


// MARK: View
extension PlayerStatsDashboard: View {
    
    var body: some View {
        Dashboard(
            items: viewModel.dashboardItems,
            isLoading: $isLoading,
            onAppear: viewModel.loadIfNeeded
        )
        .onReceive(viewModel.$isLoading) { isLoading in
            self.isLoading = isLoading
        }
    }
}


// MARK: View Model
extension PlayerStatsDashboard {
    
    final class ViewModel: PlayerStatsViewModel {
        
        @Published private(set) var dashboardItems: [Dashboard.Item] = []
        
        override init(_ playerStats: PlayerStats) {
            super.init(playerStats)
            playerStats.player
                .compactMap{ $0 }
                .map { Dashboard.Item.make(from: $0.stats) }
                .assign(to: \.dashboardItems, on: self)
            .store(in: &subs)
        }
        
        func loadIfNeeded() {
            guard dashboardItems.isEmpty else { return }
            playerStats.load()
        }
    }
    
}


// MARK: View data
extension Dashboard.Item {
    
    static func make(from stats: [Stat]) -> [Dashboard.Item] {
        return stats.reduce(into: [Stat.Kind : Values]()) { (dictionary, stat) in
            switch stat.kind {
            case .points: return
            default:
                switch stat.quantity {
                case .percentage, .value: return
                case .made: dictionary[stat.kind, default: Values(made: stat.value, attempted: 0)].made = stat.value
                case .attempted: dictionary[stat.kind, default: Values(made: 0, attempted: stat.value)].attempted = stat.value
                }
            }
        }
        .map { Dashboard.Item(kind: $0.key, values: $0.value) }
        .sorted(by: { $0.id < $1.id })
    }
    
    private struct Values {
        var made: Double
        var attempted: Double
    }
    
    private init(kind: Stat.Kind, values: Values) {
        self.init(
            id: kind.rawValue,
            data: .init(total: values.attempted, current: values.made)
        )
    }
    
}


struct PlayerStatsDashboard_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatsDashboard(viewModel: .init(
            .init(
                player: Database.examplePlayer,
                loader: Database()
            )
        ))
    }
}

