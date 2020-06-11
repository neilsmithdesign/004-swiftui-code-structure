//
//  PlayerStatsViewModel.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI
import Combine

/// Base class of both list and dashboard view models
/// Inheritence is a tool which only makes sense when it does.
/// More clearly, it's just a coincidence that list and dashboard
/// had shared View needs (isLoading property, same model injected).
class PlayerStatsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    let playerStats: PlayerStats
    var subs: Set<AnyCancellable> = .init()
    
    init(_ playerStats: PlayerStats) {
        self.playerStats = playerStats
        playerStats.player
            .map { $0 == nil }
            .assign(to: \.isLoading, on: self)
            .store(in: &subs)
    }
    
}
