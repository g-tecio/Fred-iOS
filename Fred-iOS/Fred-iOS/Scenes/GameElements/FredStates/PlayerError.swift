//
//  PlayerError.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 4/2/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerError: FredGameState {
	
	required init(game: GameScene) {
		super.init(game: game, associatedStateName: "PlayerError")
	}
	
	override func didEnter(from previousState: GKState?) {
		super.didEnter(from: previousState)
		
		/// Play Wrong tone
		game.playErrorFunction()
		game.gameControls.startSwitch.addChild(game.gameControls.startSwitch.switchBar)
	}
	
	override func willExit(to nextState: GKState) {
		super.willExit(to: nextState)
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		return stateClass is GameOver.Type
	}

}
