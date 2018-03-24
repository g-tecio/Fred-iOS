//
//  SceneState.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/21/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class SceneState: GKState {
	
	// MARK: SceneState Properties
	
		let gameViewController: GameViewController
		let sceneStateName: String
	
	// MARK: Initializer
	
	init(referenceGVC: GameViewController, sceneStateName: String) {
		self.gameViewController = referenceGVC
		self.sceneStateName = sceneStateName
		}
	
	// MARK: Overrride Methos
	
		override func didEnter(from previousState: GKState?) {
//			print("Entering state: \(sceneStateName)")
		}
	
		override func willExit(to nextState: GKState) {
//			print("Exiting state: \(sceneStateName)")
		}
}
