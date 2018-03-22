//
//  ConfigSceneState.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/21/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class ConfigSceneState: SceneState {
	
	required init(referenceGVC: GameViewController) {
		super.init(referenceGVC: referenceGVC, sceneStateName: "ConfigSceneState")

		/// Load scene
		if let skView = gameViewController.view as! SKView? {
			
			gameViewController.configScene.scaleMode = .aspectFill
			
			// Comment or remove before release to App Store
			skView.ignoresSiblingOrder = true
			skView.showsFPS = true
			skView.showsNodeCount = true
		}
	}
	
	override func didEnter(from previousState: GKState?) {
		super.didEnter(from: previousState)
		
		/// Load scene
		if let skView = gameViewController.view as! SKView? {
			skView.presentScene(gameViewController.configScene)
		}
		
	}
	
	override func willExit(to nextState: GKState) {
		super.willExit(to: nextState)
		
		// TODO: Unload Scene
		
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		return stateClass is GameSceneState.Type
	}
	
}
