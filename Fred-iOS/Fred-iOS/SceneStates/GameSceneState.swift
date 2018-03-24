//
//  GameSceneState.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/21/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSceneState: SceneState {

	// MARK: Properties
	
	
	// MARK: Initializer
	
		required init(referenceGVC: GameViewController) {
			super.init(referenceGVC: referenceGVC, sceneStateName: "GameSceneState")
		}
	
	// MARK: Overrride Methos
	
		override func didEnter(from previousState: GKState?) {
			super.didEnter(from: previousState)
			
			/// Present scene
			if let skView = gameViewController.view as! SKView? {
				skView.presentScene(gameViewController.gameScene, transition: SKTransition.flipVertical(withDuration: 0.3))
			}
		}
	
		override func willExit(to nextState: GKState) {
			super.willExit(to: nextState)
		}
	
		override func isValidNextState(_ stateClass: AnyClass) -> Bool {
			return stateClass is ConfigSceneState.Type
		}

}
