//
//  ConfigControls.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/24/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

struct ConfigControls {
	
	/// Title Label
	let titleLabel: SKLabelNode
	
	/// Exit Button and Label
	let exitButtonSprite:SKSpriteNode
	let exitLabel: SKLabelNode
	
	init(inThisScene: ConfigScene) {
		
		/// Title Label
		titleLabel = SKLabelNode.init(text: "Configuration")
		titleLabel.name = "titleLabel"
		titleLabel.fontName = "Avenir-Heavy"
		titleLabel.horizontalAlignmentMode = .center
		titleLabel.verticalAlignmentMode = .center
		titleLabel.fontColor = .white
		titleLabel.fontSize = 32
		titleLabel.zPosition = 2
		titleLabel.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*12/13))
		
		/// Exit  Button
		exitButtonSprite = SKSpriteNode.init(imageNamed: "StartOn")
		exitButtonSprite.name = "exitButton"
		exitButtonSprite.zPosition = 1
		exitButtonSprite.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*1/13))
		
		/// Resizing depending to screen size
		let resizeFactorX:CGFloat = inThisScene.size.width/380.0
		let resizeFactorY:CGFloat = inThisScene.size.height/850.0
		let originalSize = exitButtonSprite.size
		exitButtonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
		
		/// Exit Game label
		exitLabel = SKLabelNode.init(text: "Return to Game")
		exitLabel.name = "exitLabel"
		exitLabel.fontName = "Avenir-Heavy"
		exitLabel.horizontalAlignmentMode = .center
		exitLabel.verticalAlignmentMode = .center
		exitLabel.fontColor = .white
		exitLabel.fontSize = 24
		exitLabel.zPosition = 2
		exitLabel.position = CGPoint(x: 0, y: 0)
		
		/// Add Label to Scene
		exitButtonSprite.addChild(exitLabel)
	}
	
}
