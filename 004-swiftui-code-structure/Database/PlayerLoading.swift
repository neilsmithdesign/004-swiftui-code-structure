//
//  PlayerLoading.swift
//  004-swiftui-view-models
//
//  Created by Neil Smith on 09/06/2020.
//  Copyright © 2020 Neil Smith Design LTD. All rights reserved.
//

import Foundation
import Combine

protocol PlayerLoading {
    func loadExamplePlayer(_ completion: @escaping (Player) -> Void)
    func loadExamplePlayer() -> AnyPublisher<Player, Never>
}

extension Database: PlayerLoading {
    
    func loadExamplePlayer(_ completion: @escaping (Player) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(Database.examplePlayer)
        }
    }
    
    func loadExamplePlayer() -> AnyPublisher<Player, Never> {
        return Just(Database.examplePlayer)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
