//
//  LoadingList.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI

protocol ListItem: Identifiable {
    var leftText: String { get }
    var rightText: String { get }
}

struct LoadingList<Item> where Item: ListItem {
    let items: [Item]
    let onAppear: () -> Void
    @Binding var isLoading: Bool
}

extension LoadingList: View {
    var body: some View {
        ZStack {
            List(items) { item in
                HStack {
                    Text(item.leftText).font(Font.system(.headline).bold())
                    Spacer()
                    Text(item.rightText).foregroundColor(.gray)
                }
            }
            .opacity(isLoading ? 0.2 : 1)
            ActivityIndicator(isAnimating: self.$isLoading, style: .large)
        }.onAppear(perform: onAppear)
    }

}


struct LoadingList_Preview: PreviewProvider {
    
    static var previews: some View {
        LoadingList<TestItem>(items: (0..<10).map { _ in TestItem() }, onAppear: {}, isLoading: .constant(true))
    }
    
}

struct TestItem: ListItem {
    var leftText: String { "Left" }
    var rightText: String { "Right" }
    let id: UUID
    init() {
        id = .init()
    }
}
