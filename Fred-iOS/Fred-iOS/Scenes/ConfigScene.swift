//
//  configScene.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/20/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class ConfigScene: SKScene {
	
	/// GameViewControl setup as reference to handle SceneStates
	var gameViewController: GameViewController!

	convenience init(fileNamed: String, referenceGVC: GameViewController) {
		self.init(fileNamed: fileNamed)!
		gameViewController = referenceGVC
	}
	
	override func didMove(to view: SKView) {
		/// Load elements of Scene
		
		
		
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//		for touch in touches {
//			let location = touch.location(in: self)
//			let item = atPoint(location)
//			if item === self.childNode(withName: "exitLabel") {
				gameViewController.sceneStateMachine.enter(GameSceneState.self)
//			}
//		}
	}
}
