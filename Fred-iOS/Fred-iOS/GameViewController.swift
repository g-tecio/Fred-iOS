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
	
	// MARK: Override Methods
	
		override func viewDidLoad() {
			super.viewDidLoad()
			
			/// GameScene Setup - with Code
			gameScene = GameScene.init(sceneSize: view.bounds.size, referenceGVC: self)

			/// ConfigScene Setup - with Code
			configScene = ConfigScene.init(sceneSize: view.bounds.size, referenceGVC: self)
			
			/// Creates SceneStateMachine and adds states, then enters GameSceneState
			sceneStateMachine = GKStateMachine(states: [	GameSceneState(referenceGVC: self),
															ConfigSceneState(referenceGVC: self) ] )
			sceneStateMachine.enter(GameSceneState.self)
		}
	
		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
		}
	
}
