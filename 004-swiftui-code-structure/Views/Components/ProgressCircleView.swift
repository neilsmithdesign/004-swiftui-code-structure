//
//  ProgressCircleView.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI

// MARK: Interface
struct ProgressCircleView {
    let data: ProgressCircleData
}

// MARK: View
extension ProgressCircleView: View {
    
    var body: some View {
        ZStack {
            ProgressCircle.backing
            ProgressCircle(value: self.data.percentage, animatable: true)
            Text(self.data.percentageString)
                .font(Font.system(.title, design: .rounded).bold())
                .foregroundColor(Color.based(onPercentage: self.data.percentage))
        }
        .padding()
        
    }
    
}



// MARK: View data
struct ProgressCircleData {
    let total: Double
    let current: Double
    
    // 0 = no progress, 1 = completed
    var percentage: Double {
        guard total > 0 else { return 0 }
        let p = (current / total)
        return min(1, p)
    }
    
    var percentageString: String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.roundingMode = .halfUp
        nf.maximumFractionDigits = 1
        return (nf.string(from: NSNumber(value: (percentage * 100))) ?? "-") + "%"
    }
}
