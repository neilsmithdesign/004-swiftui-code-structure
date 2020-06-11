//
//  PlayerStats.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI
import Combine

/// Scene-specific model
/// Main role is management of the in-memory cache of data
/// Could be extended to expose other CRUD properties and methods.
final class PlayerStats {

    private(set) var player: CurrentValueSubject<Player?, Never>

    init(player: Player? = nil, loader: PlayerLoading) {
        self.loader = loader
        self.player = .init(player)
    }
    
    func load() {
        self.loadingSub = loader.loadExamplePlayer().sink(receiveValue: player.send)
    }
    
    // MARK: Private
    private let loader: PlayerLoading
    private var loadingSub: AnyCancellable?
    
}
