//
//  GameControls.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/19/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

struct GameControls {
	
	/// Start Game Button and Label
	let startButtonSprite:SKSpriteNode
	let startOnTexture: SKTexture
	let startOffTexture: SKTexture
	let startLabel: SKLabelNode

	/// Configuration Button
	let configButtonSprite:SKSpriteNode
	
	
	init(inThisScene: GameScene) {
		/// Start Game Button
		startOnTexture = SKTexture(imageNamed: "StartOn")
		startOffTexture = SKTexture(imageNamed: "StartOff")
		startButtonSprite = SKSpriteNode.init(texture: startOnTexture)
		startButtonSprite.name = "startButton"
		startButtonSprite.zPosition = 1
		startButtonSprite.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*1/13)-15)
		
		/// Resizing depending to screen size
		let resizeFactorX:CGFloat = inThisScene.size.width/380.0
		let resizeFactorY:CGFloat = inThisScene.size.height/850.0
		let originalSize = startButtonSprite.size
		startButtonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
		
		/// Add Button to Scene
		//inThisScene.addChild(startButtonSprite)
		
		/// Start Game label
		startLabel = SKLabelNode.init(text: "Loading...")
		startLabel.name = "startLabel"
		startLabel.fontName = "Avenir-Heavy"
		startLabel.horizontalAlignmentMode = .center
		startLabel.verticalAlignmentMode = .center
		startLabel.fontColor = .white
		startLabel.fontSize = 24
		startLabel.zPosition = 2
		startLabel.position = CGPoint(x: 0, y: 0)
		
		/// Add Label to Scene
		startButtonSprite.addChild(startLabel)
		
		/// Configuration Button
		configButtonSprite = SKSpriteNode.init(imageNamed: "cogButtonBlack")
		configButtonSprite.zPosition = 3
		configButtonSprite.position = CGPoint(x: inThisScene.size.width*45/50, y: (inThisScene.size.height*1/13)-15)
		
		/// Add Label to Scene
		//inThisScene.addChild(configButtonSprite)
		
	}

}
