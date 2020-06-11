//
//  Stat.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import Foundation

struct Stat {
    let value: Double
    let kind: Kind
    let quantity: Quantity
    
    var label: String {
        kind.abbreviation + quantity.unit
    }
    
    init(_ value: Double, _ kind: Kind, _ quantity: Quantity = .value) {
        self.value = value
        self.kind = kind
        self.quantity = (kind == .points) ? .value : quantity
    }
    
    var index: Int {
        func index(_ multipler: Int, _ quantity: Quantity) -> Int {
            (Quantity.allCases.count * multipler) + quantity.rawValue
        }
        switch (kind) {
        case .points: return kind.rawValue
        default: return index(kind.rawValue - 1, quantity)
        }
    }
}

extension Stat {
    enum Kind: Int, CaseIterable {
        case points = 0
        case fieldGoals = 1
        case threePointFieldGoals = 2
        case freeThrows = 3
        
        var abbreviation: String {
            switch self {
            case .points: return "PTS"
            case .fieldGoals: return "FG"
            case .threePointFieldGoals: return "3P"
            case .freeThrows: return "FT"
            }
        }
        
        var description: String {
            switch self {
            case .points: return "points"
            case .fieldGoals: return "field goals"
            case .threePointFieldGoals: return "three point field goals"
            case .freeThrows: return "free throws"
            }
        }
        
    }

}

extension Stat {
    enum Quantity: Int, CaseIterable {
        case value = 0
        case made = 1
        case attempted = 2
        case percentage = 3
        
        var unit: String {
            switch self {
            case .value: return ""
            case .made: return "M"
            case .attempted: return "A"
            case .percentage: return "%"
            }
        }
        
        var description: String {
            switch self {
            case .value: return ""
            case .made: return "made"
            case .attempted: return "attempted"
            case .percentage: return "percentage"
            }
        }
    }
}
