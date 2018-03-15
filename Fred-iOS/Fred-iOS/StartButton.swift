//
//  StartButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/13/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

struct StartButton {
    // Start Button
    let startButtonSprite:SKSpriteNode
    let startOnTexture: SKTexture
    let startOffTexture: SKTexture
    
    // Label
    let startLabel: SKLabelNode

    init(inThisScene: GameScene) {
        // Start Button
        startOnTexture = SKTexture(imageNamed: "StartOn")
        startOffTexture = SKTexture(imageNamed: "StartOff")
        startButtonSprite = SKSpriteNode.init(texture: startOnTexture)
        startButtonSprite.name = "startButton"
        startButtonSprite.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*1/13)-15)
        
        // Resizing depending to screen size
        let resizeFactorX:CGFloat = inThisScene.size.width/380.0
        let resizeFactorY:CGFloat = inThisScene.size.height/850.0
        let originalSize = startButtonSprite.size
        startButtonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
        
        // Add to Scene
        inThisScene.addChild(startButtonSprite)
        
        // Start label
        startLabel = SKLabelNode.init(text: "Loading...")
        startLabel.name = "startLabel"
        startLabel.fontName = "Avenir-Heavy"
        startLabel.horizontalAlignmentMode = .center
        startLabel.verticalAlignmentMode = .center
        startLabel.fontColor = .white
        startLabel.fontSize = 24
        startLabel.zPosition = 1
        startLabel.position = CGPoint(x: 0, y: 0)
        // Add to Scene
        startButtonSprite.addChild(startLabel)
    }
}
