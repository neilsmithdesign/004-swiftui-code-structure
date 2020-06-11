//
//  Database.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import Foundation

struct Database {
    
    static let examplePlayer: Player = .init(
        "Damian Lillard",
        stats: [
            .init(28.9, .points),
            
            .init(9.2, .fieldGoals, .made),
            .init(20.0, .fieldGoals, .attempted),
            .init((9.2 / 20.0), .fieldGoals, .percentage),
            
            .init(3.9, .threePointFieldGoals, .made),
            .init(9.9, .threePointFieldGoals, .attempted),
            .init((3.9 / 9.9), .threePointFieldGoals, .percentage),
            
            .init(6.7, .freeThrows, .made),
            .init(7.6, .freeThrows, .attempted),
            .init((6.7 / 7.6), .freeThrows, .percentage)
        ]
    )
    
}
