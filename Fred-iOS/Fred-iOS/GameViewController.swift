//
//  GameViewController.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
	
	// MARK: App Properties
	
		/// Scene State Machine
		var sceneStateMachine: GKStateMachine!
	
		/// Scenes
		var gameScene: GameScene!
		var configScene: ConfigScene!
	
		/// Configuration
		var intervalBetweenCycles = 9
		var intervalButtonAnimation = 21
		var intervalBetweenTurns = 4
		var intervalPlayerWaiting = 180
		var delayedReleaseTime = 3
	
	// MARK: Override Methods
	
		override func viewDidLoad() {
			super.viewDidLoad()
			
			/// GameScene Setup - with Code
			gameScene = GameScene.init(sceneSize: view.bounds.size, referenceGVC: self)

			/// ConfigScene Setup - with File
			configScene = ConfigScene.init(fileNamed: "ConfigScene", referenceGVC: self)
			
			/// Creates SceneStateMachine and adds states, then enters GameSceneState
			sceneStateMachine = GKStateMachine(states: [	GameSceneState(referenceGVC: self),
															ConfigSceneState(referenceGVC: self) ] )
			sceneStateMachine.enter(GameSceneState.self)
		}
	
		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
		}
	
}
