//
//  PlayerStatsList.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI
import Combine


// MARK: Interface
struct PlayerStatsList {
    
    @ObservedObject var viewModel: PlayerStatsList.ViewModel
    @State private var isLoading: Bool = false
    
}

// MARK: View
extension PlayerStatsList: View {
    
    var body: some View {
        LoadingList<Stat>(
            items: viewModel.listItems,
            onAppear: viewModel.loadIfNeeded,
            isLoading: $isLoading
        )
        .onReceive(viewModel.$isLoading) { isLoading in
            self.isLoading = isLoading
        }
    }

}


// MARK: View model
extension PlayerStatsList {
  
    final class ViewModel: PlayerStatsViewModel {
        @Published private(set) var listItems: [Stat] = []
        
        override init(_ playerStats: PlayerStats) {
            super.init(playerStats)
            playerStats.player
                .compactMap{ $0?.stats }
                .assign(to: \.listItems, on: self)
            .store(in: &subs)
        }
        
        func loadIfNeeded() {
            guard listItems.isEmpty else { return }
            playerStats.load()
        }

    }
    
}


// MARK: View data
extension Stat: ListItem {
    
    var id: Int { self.index }

    var leftText: String {
        let n = quantity == .percentage ? (value * 100) : value
        return String(format: "%.1f", n)
    }
    
    var rightText: String {
        label
    }
    
}
