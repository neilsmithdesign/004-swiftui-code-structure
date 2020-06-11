//
//  Player.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import Foundation

struct Player {
    let name: String
    let stats: [Stat]
}

extension Player {
    
    init(_ name: String, stats: [Stat]) {
        self.name = name
        self.stats = stats.sorted(by: { $0.index < $1.index })
    }
    
}
