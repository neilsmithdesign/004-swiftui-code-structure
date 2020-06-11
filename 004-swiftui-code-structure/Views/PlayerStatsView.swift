//
//  PlayerStatsView.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 08/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import SwiftUI
import Combine

struct PlayerStatsView {
    
    @ObservedObject var viewModel: ViewModel
    @State private var currentSection: Section = .list

    init(model: PlayerStats) {
        self.viewModel = .init(model)
        self.dashboard = .init(model)
        self.list = .init(model)
    }
    
    private let dashboard: PlayerStatsDashboard.ViewModel
    private let list: PlayerStatsList.ViewModel
    
}

extension PlayerStatsView: View {
    var body: some View {
        NavigationView {
            VStack {
                SegmentControl(current: $currentSection).padding()
                Group {
                    if currentSection == .list {
                        PlayerStatsList(viewModel: list)
                    } else {
                        PlayerStatsDashboard(viewModel: dashboard)
                    }
                }
                Spacer()
            }
            .navigationBarTitle(viewModel.name)
        }
    }
    
}

extension PlayerStatsView {
    
    final class ViewModel: PlayerStatsViewModel {
        @Published private(set) var name: String = ""
        override init(_ playerStats: PlayerStats) {
            super.init(playerStats)
            playerStats.player
                .compactMap { $0?.name }
                .assign(to: \.name, on: self)
                .store(in: &subs)
        }
    }
    
}


// MARK: Private helpers
private enum Section: Int, CaseIterable, Identifiable {
    case list = 0
    case dashboard = 1
    
    var id: Int { self.rawValue }
    
    var title: String {
        switch self {
        case .list: return "List"
        case .dashboard: return "Dashboard"
        }
    }
}

private struct SegmentControl: View {
    @Binding var current: Section
    
    var body: some View {
        Picker(selection: $current, label: Text("---")) {
            ForEach(Section.allCases) { Text($0.title).tag($0) }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
