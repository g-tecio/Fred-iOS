//
//  FredGameState.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/12/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredGameState: GKState {
    
    let game: GameScene
    let associatedStateName: String
    
    
    init(game: GameScene, associatedStateName: String) {
        self.game = game
        self.associatedStateName = associatedStateName
    }
    
    override func didEnter(from previousState: GKState?) {
//        print("Entering state: \(associatedStateName)")
    }
    
    override func willExit(to nextState: GKState) {
//        print("Exiting state: \(associatedStateName)")
    }
}
