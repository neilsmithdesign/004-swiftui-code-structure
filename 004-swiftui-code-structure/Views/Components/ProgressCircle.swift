//
//  ProgressCircle.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI


// MARK: Interface
struct ProgressCircle {

    private let kind: Kind
    private let animatable: Bool
    @State private var on: Bool = false
    
    init(value: Double, animatable: Bool = false) {
        self.kind = .value(value)
        self.animatable = animatable
    }
    
}


// MARK: View
extension ProgressCircle: View {
    
    var body: some View {
        Ring(start: .degrees(0-90), end: .degrees(endDegrees-90))
            .trim(to: animatable ? (on ? trimEnd : 0.0) : trimEnd)
            .stroke(
                color,
                style: .init(lineWidth: 12, lineCap: .round, lineJoin: .round))
            .padding(10)
            .onAppear {
                guard self.on != true else { return }
                withAnimation(Animation.easeInOut(duration: 10)) {
                    self.on = true
                }
        }
    }
    
}


// MARK: Private properties
private extension ProgressCircle {
    
    enum Kind {
        case backing
        case value(Double)
    }
    
    var value: Double {
        switch kind {
        case .backing: return 1
        case let .value(v): return v
        }
    }
    
    var endDegrees: Double {
        max(0, min(360, 360.0 * value))
    }
    
    var trimEnd: CGFloat {
        CGFloat((endDegrees / 360.0) + 90)
    }

    var color: Color {
        switch kind {
        case .backing: return Color.gray.opacity(0.4)
        case let .value(v): return Color.based(onPercentage: v)
        }
    }
    
}

// MARK: Backing circle
extension ProgressCircle {
    
    private init(kind: Kind) {
        self.kind = kind
        self.animatable = false
    }
    
    static var backing: ProgressCircle { .init(kind: .backing) }
    
}

struct ProgressCircle_Preview: PreviewProvider {
    
    static var previews: some View {
        ProgressCircle(value: 0.5)
    }
    
}

extension Color {
    
    /// Value parameter between 0 and 1.
    static func based(onPercentage value: Double) -> Color {
        switch value {
        case 0.8..<1.0: return .green
        case 0.6..<0.8: return .yellow
        case 0.5..<0.6: return .orange
        default: return .red
        }
    }
    
}

