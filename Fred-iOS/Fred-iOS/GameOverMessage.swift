//
//  GameOverMessage.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/15/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

struct GameOverMessage {
    
    // Label
    let gameOverLabel: SKLabelNode
    
    init(inThisScene: GameScene) {
        // Start label
        gameOverLabel = SKLabelNode.init(text: "GAME OVER")
        gameOverLabel.name = "gameOverLabel"
        gameOverLabel.fontName = "Avenir-Heavy"
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.verticalAlignmentMode = .center
        gameOverLabel.fontColor = .red
        gameOverLabel.fontSize = 50
        gameOverLabel.zPosition = 20
        gameOverLabel.isHidden = true
        gameOverLabel.position = CGPoint(x: inThisScene.size.width/2, y: inThisScene.size.height/2)
        // Add to Scene
        inThisScene.addChild(gameOverLabel)
    }
}
