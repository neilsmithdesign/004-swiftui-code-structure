//
//  Dashboard.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI

struct Dashboard {
    let items: [Item]
    @Binding var isLoading: Bool
    let onAppear: () -> Void
}

extension Dashboard: View {
    var body: some View {
        ZStack {
            ActivityIndicator(isAnimating: self.$isLoading, style: .large)
            VStack {
                ForEach(items) { item in
                    ProgressCircleView(data: item.data)
                }
            }
            .opacity(isLoading ? 0 : 1)
        }.onAppear(perform: onAppear)
    }
    
}

extension Dashboard {
    struct Item: Identifiable {
        let id: Int
        let data: ProgressCircleData
    }
    
}

struct Dashboard_Preview: PreviewProvider {
    
    static var previews: some View {
        Dashboard(
            items: [.init(id: 0, data: .init(total: 20.0, current: 9.2))],
            isLoading: .constant(false),
            onAppear: {}
        )
    }
    
}
