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

	// MARK: SceneState Properties

		let game: GameScene
		let associatedStateName: String

	// MARK: Initializer
    
		init(game: GameScene, associatedStateName: String) {
			self.game = game
			self.associatedStateName = associatedStateName
		}
	
	// MARK: Overrride Methos
	
		override func didEnter(from previousState: GKState?) {
//	        print("Entering state: \(associatedStateName)")
		}
	
		override func willExit(to nextState: GKState) {
//	         print("Exiting state: \(associatedStateName)")
		}
	
}
