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
	
		/// Slider for Delayed Release Time
		var sliderDelayedReleaseTime: SliderSK!
		var sliderBetweenCyclesTime: SliderSK!
		var sliderButtonAnimationTime: SliderSK!
		var sliderBetweenTurnsTime: SliderSK!
		var sliderPlayerWaitingTime: SliderSK!
	
		/// Config Controls
		var configControls: ConfigControls!
	
	// MARK: Config Initialization
	
		/// Custom Initializer
		init(sceneSize: CGSize, referenceGVC: GameViewController) {
			
			/// Set reference of GameViewControl
			gameViewController = referenceGVC
			
			/// Create scene from code
			super.init(size: sceneSize)

			/// Controls
			configControls = ConfigControls.init(inThisScene: self)
			
			/// SliderSK
			sliderDelayedReleaseTime = SliderSK.init(inThisScene: self, initialValue: GameData.shared.framesDelayedRelease, minValue: 0, maxValue: 60, title: "Delayed Release Time", postionY: sceneSize.height*16/20)
			
			sliderBetweenCyclesTime = SliderSK.init(inThisScene: self, initialValue: GameData.shared.framesBetweenCycles, minValue: 0, maxValue: 60, title: "Between Cycles Time", postionY: sceneSize.height*13/20)
			
			sliderButtonAnimationTime = SliderSK.init(inThisScene: self, initialValue: GameData.shared.framesButtonAnimation, minValue: 0, maxValue: 60, title: "Button Animation Time", postionY: sceneSize.height*10/20)
			
			sliderBetweenTurnsTime = SliderSK.init(inThisScene: self, initialValue: GameData.shared.framesBetweenTurns, minValue: 0, maxValue: 60, title: "Between Turns Time", postionY: sceneSize.height*7/20)
			
			sliderPlayerWaitingTime = SliderSK.init(inThisScene: self, initialValue: GameData.shared.framesPlayerWaiting, minValue: 0, maxValue: 180, title: "Player Waiting Time", postionY: sceneSize.height*4/20)

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
			
			addChild(configControls.titleLabel)
			addChild(configControls.exitButtonSprite)
			addChild(sliderDelayedReleaseTime)
			addChild(sliderBetweenCyclesTime)
			addChild(sliderButtonAnimationTime)
			addChild(sliderBetweenTurnsTime)
			addChild(sliderPlayerWaitingTime)
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
				else {
					/// Slider
					if item.name == sliderDelayedReleaseTime.name {
						sliderDelayedReleaseTime.beingChanged = true
						sliderDelayedReleaseTime.backgroundSliderSK.color = .gray
					}
					if item.name == sliderBetweenCyclesTime.name {
						sliderBetweenCyclesTime.beingChanged = true
						sliderBetweenCyclesTime.backgroundSliderSK.color = .gray
					}
					if item.name == sliderButtonAnimationTime.name {
						sliderButtonAnimationTime.beingChanged = true
						sliderButtonAnimationTime.backgroundSliderSK.color = .gray
					}
					if item.name == sliderBetweenTurnsTime.name {
						sliderBetweenTurnsTime.beingChanged = true
						sliderBetweenTurnsTime.backgroundSliderSK.color = .gray
					}
					if item.name == sliderPlayerWaitingTime.name {
						sliderPlayerWaitingTime.beingChanged = true
						sliderPlayerWaitingTime.backgroundSliderSK.color = .gray
					}
				}
			}
		}
	
		override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		
			let valuePoint = touches.first!.location(in: self).x

			if sliderDelayedReleaseTime.beingChanged {
				GameData.shared.framesDelayedRelease = self.sliderDelayedReleaseTime.setValueFromPoint(point: valuePoint)
			}
			if sliderBetweenCyclesTime.beingChanged {
				GameData.shared.framesBetweenCycles = self.sliderBetweenCyclesTime.setValueFromPoint(point: valuePoint)
			}
			if sliderButtonAnimationTime.beingChanged {
				GameData.shared.framesButtonAnimation = self.sliderButtonAnimationTime.setValueFromPoint(point: valuePoint)
			}
			if sliderBetweenTurnsTime.beingChanged {
				GameData.shared.framesBetweenTurns = self.sliderBetweenTurnsTime.setValueFromPoint(point: valuePoint)
			}
			if sliderPlayerWaitingTime.beingChanged {
				GameData.shared.framesPlayerWaiting = self.sliderPlayerWaitingTime.setValueFromPoint(point: valuePoint)
			}
			
		}
	
		override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
			
			if sliderDelayedReleaseTime.beingChanged {
				sliderDelayedReleaseTime.beingChanged = false
				sliderDelayedReleaseTime.backgroundSliderSK.color = .white
			}
			if sliderBetweenCyclesTime.beingChanged {
				sliderBetweenCyclesTime.beingChanged = false
				sliderBetweenCyclesTime.backgroundSliderSK.color = .white
			}
			if sliderButtonAnimationTime.beingChanged {
				sliderButtonAnimationTime.beingChanged = false
				sliderButtonAnimationTime.backgroundSliderSK.color = .white
			}
			if sliderBetweenTurnsTime.beingChanged {
				sliderBetweenTurnsTime.beingChanged = false
				sliderBetweenTurnsTime.backgroundSliderSK.color = .white
			}
			if sliderPlayerWaitingTime.beingChanged {
				sliderPlayerWaitingTime.beingChanged = false
				sliderPlayerWaitingTime.backgroundSliderSK.color = .white
			}
		}

}
