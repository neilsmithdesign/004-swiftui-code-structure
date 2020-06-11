//
//  Ring.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI

struct Ring: Shape {
    
    var start: Angle
    var end: Angle
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let top = CGPoint(
            x: rect.center.x + rect.radius * cos(CGFloat(start.radians)),
            y: rect.center.y + rect.radius * sin(CGFloat(start.radians))
        )
        p.move(to: top)
        p.addArc(
            center: rect.center,
            radius: rect.radius,
            startAngle: start,
            endAngle: end,
            clockwise: false
        )
        return p
    }
    
}

private extension CGRect {
    var center: CGPoint {
        .init(x: self.midX, y: self.midY)
    }
    var radius: CGFloat {
        min(self.width, self.height) / 2
    }
}
