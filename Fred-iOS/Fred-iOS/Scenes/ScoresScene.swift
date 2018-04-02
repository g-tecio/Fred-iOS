//
//  ScoresScene.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 4/1/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class ScoresScene: SKScene {
	
	// MARK: Config Properties
	
		/// GameViewControl setup as reference to handle SceneStates
		var gameViewController: GameViewController!
	
		/// Scores Controls
		var scoresControls: ScoresControls!
	
	// MARK: Scores Initialization
	
		/// Custom Initializer
		init(sceneSize: CGSize, referenceGVC: GameViewController) {
			
			/// Set reference of GameViewControl
			gameViewController = referenceGVC
			
			/// Create scene from code
			super.init(size: sceneSize)
			
			/// Controls
			scoresControls = ScoresControls.init(inThisScene: self)
			
			/// Load scene
			if let skView = gameViewController.view as! SKView? {
				self.size = skView.bounds.size
				self.scaleMode = .aspectFill
				
				// TODO: Comment or remove before release to App Store
				skView.ignoresSiblingOrder = true
				skView.showsFPS = true
				skView.showsNodeCount = true
			}
		}
	
		/// Included because is a requisite if a custom Init is used
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	
	// MARK: Override Methods
	
		/// View presented
		override func didMove(to view: SKView) {
			
			addChild(scoresControls.titleLabel)
			addChild(scoresControls.exitButtonSprite)
		}
	
		/// Before another Scence will be presented
		override func willMove(from view: SKView) {
			removeAllChildren()
		}
	
		/// Touch event
		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			for touch in touches {
				let location = touch.location(in: self)
				let item = atPoint(location)
				
				/// Exit and return to GameScene
				if (item.name == "exitLabel") || (item.name == "exitButton") {
					gameViewController.sceneStateMachine.enter(GameSceneState.self)
				}
			}
		}

}
