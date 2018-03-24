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
	
	// MARK: Config Properties
	
		/// GameViewControl setup as reference to handle SceneStates
		var gameViewController: GameViewController!
	
		///
		let sliderSample = SliderSK.init(width: 600, height: 20, text: "Time")

	
	// MARK: Config Initialization
	
		convenience init(fileNamed: String, referenceGVC: GameViewController) {
			
			/// Creates Scene from file
			self.init(fileNamed: fileNamed)!
			
			/// Set reference of GameViewControl
			gameViewController = referenceGVC
			
			/// Load scene
			if let skView = gameViewController.view as! SKView? {

				self.scaleMode = .aspectFill
				
				// TODO: Comment or remove before release to App Store
//				skView.ignoresSiblingOrder = true
				skView.showsFPS = true
				skView.showsNodeCount = true
			}
		}
	
	// MARK: Override Methods
	
		/// View presented
		override func didMove(to view: SKView) {
			
			sliderSample.position.y = 400
			addChild(sliderSample)
			sliderSample.valueSliderSK = 5
			
		}
	
		/// Touch event
		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			for touch in touches {
				let location = touch.location(in: self)
				let item = atPoint(location)
				
				
				
				/// Exit and return to GameScene
				if (item === self.childNode(withName: "exitLabel")) || (item === self.childNode(withName: "exitButton")){
					gameViewController.sceneStateMachine.enter(GameSceneState.self)
				}
			}
		}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		self.sliderSample.backgroundSliderSK.color = .gray
		
		//sliderSKElement.position = CGPoint(x: (-CGFloat(backgroundSliderSK.size.width)/2.0)+CGFloat(backgroundSliderSK.size.width)/CGFloat(maxSliderSK-minSliderSK)*CGFloat(valueSliderSK), y: CGFloat(0.0))
		
		let x = touches.first!.location(in: self).x - sliderSample.backgroundSliderSK.position.x
		print("+++++++")
		print("loc.x: \(touches.first!.location(in: self).x)")
		print("pos.x: \(sliderSample.backgroundSliderSK.position.x)")
		
		let pos = max(fmin(x, sliderSample.widthSliderSK), 0.0)
		print(pos)
		
		sliderSample.sliderSKElement.position = CGPoint(x: CGFloat(sliderSample.backgroundSliderSK.position.x + pos), y: CGFloat(0.0))
		sliderSample.valueSliderSK = Int(pos / sliderSample.widthSliderSK)
		
//		_ = targetClicked!.perform(actionClicked, with: self)
		
	}
	
	
	
}
