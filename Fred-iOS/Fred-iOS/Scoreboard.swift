//
//  Scoreboard.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/13/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

struct Scoreboard {
    
    // Background
    let backgroundScoreboardSprite: SKSpriteNode
    // State
    let stateSprint: SKSpriteNode
    let state1Texture: SKTexture
    let state2Texture: SKTexture
    let state3Texture: SKTexture
    let state4Texture: SKTexture
    let state5Texture: SKTexture
    // Labels for Names
    let fredLabel: SKLabelNode
    let playerLabel: SKLabelNode
    // Repeat Symbol
    let fredRepeat: SKSpriteNode
    let fredRepeatOn: SKTexture
    let fredRepeatOff: SKTexture
    // New Symbol
    let fredNew: SKSpriteNode
    let fredNewOn: SKTexture
    let fredNewOff: SKTexture
    // Correct Symbol
    let playerCorrect: SKSpriteNode
    let playerCorrectOn: SKTexture
    let playerCorrectOff: SKTexture
    // Error Symbol
    let playerError: SKSpriteNode
    let playerErrorOn: SKTexture
    let playerErrorOff: SKTexture
    // Star Symbol
    var playerStars: [SKSpriteNode] = []
    let starOn: SKTexture
    let starOff: SKTexture
    // Star value
    let starValue: SKLabelNode
    // Score and counters
    let fredCount: SKLabelNode
    let playerCount: SKLabelNode
    let scoreTitle: SKLabelNode
    let score: SKLabelNode

    init(inThisScene: GameScene) {
        // Resizing factors
        let resizeFactorX:CGFloat = inThisScene.size.width/380.0
        let resizeFactorY:CGFloat = inThisScene.size.height/710.0
        // Background
        backgroundScoreboardSprite = SKSpriteNode.init(texture: SKTexture(imageNamed: "Scoreboard"))
        backgroundScoreboardSprite.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*12/13)-30)
        let originalSize = backgroundScoreboardSprite.size
        backgroundScoreboardSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
        inThisScene.addChild(backgroundScoreboardSprite)
        // State indicator
        state1Texture = SKTexture(imageNamed: "state1")
        state2Texture = SKTexture(imageNamed: "state2")
        state3Texture = SKTexture(imageNamed: "state3")
        state4Texture = SKTexture(imageNamed: "state4")
        state5Texture = SKTexture(imageNamed: "state4")
        stateSprint = SKSpriteNode.init(texture: state1Texture)
        stateSprint.zPosition = 2
        stateSprint.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*17/40), y: Int(0))
        backgroundScoreboardSprite.addChild(stateSprint)
        // Fred Label
        fredLabel = SKLabelNode.init(text: "Fred")
        fredLabel.fontName = "Avenir-Heavy"
        fredLabel.horizontalAlignmentMode = .left
        fredLabel.fontColor = .lightGray
        fredLabel.fontSize = 24
        fredLabel.zPosition = 4
        fredLabel.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*7/20), y: Int(backgroundScoreboardSprite.size.height*4/20))
        backgroundScoreboardSprite.addChild(fredLabel)
        // Player Label
        playerLabel = SKLabelNode.init(text: "Player")
        playerLabel.fontName = "Avenir-Heavy"
        playerLabel.horizontalAlignmentMode = .left
        playerLabel.fontColor = .lightGray
        playerLabel.fontSize = 24
        playerLabel.zPosition = 4
        playerLabel.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*7/20), y: Int(-backgroundScoreboardSprite.size.height*2/20))
        backgroundScoreboardSprite.addChild(playerLabel)
        // Repeat Symbol
        fredRepeatOn = SKTexture(imageNamed: "RepeatOn")
        fredRepeatOff = SKTexture(imageNamed: "RepeatOff")
        fredRepeat = SKSpriteNode.init(texture: fredRepeatOff)
        fredRepeat.zPosition = 4
        fredRepeat.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*1/50), y: Int(backgroundScoreboardSprite.size.height*11/40))
        backgroundScoreboardSprite.addChild(fredRepeat)
        // New Symbol
        fredNewOn = SKTexture(imageNamed: "NewOn")
        fredNewOff = SKTexture(imageNamed: "NewOff")
        fredNew = SKSpriteNode.init(texture: fredNewOff)
        fredNew.zPosition = 4
        fredNew.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*2/40), y: Int(backgroundScoreboardSprite.size.height*11/40))
        backgroundScoreboardSprite.addChild(fredNew)
        // Correct Symbol
        playerCorrectOn = SKTexture.init(imageNamed: "CorrectOn")
        playerCorrectOff = SKTexture.init(imageNamed: "CorrectOff")
        playerCorrect =  SKSpriteNode.init(texture: playerCorrectOff)
        playerCorrect.zPosition = 4
        playerCorrect.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*1/50), y: Int(-backgroundScoreboardSprite.size.height*1/40))
        backgroundScoreboardSprite.addChild(playerCorrect)
        // Error Symbol
        playerErrorOn = SKTexture.init(imageNamed: "ErrorOn")
        playerErrorOff = SKTexture.init(imageNamed: "ErrorOff")
        playerError = SKSpriteNode.init(texture: playerErrorOff)
        playerError.zPosition = 4
        playerError.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*2/40), y: Int(-backgroundScoreboardSprite.size.height*1/40))
        backgroundScoreboardSprite.addChild(playerError)
        // Stars
        starOn = SKTexture.init(imageNamed: "StarOn")
        starOff = SKTexture.init(imageNamed: "StarOff")
        for starNum in 1...10 {
            let starTemp = SKSpriteNode.init(texture: starOff)
            starTemp.zPosition = 4
            starTemp.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width/15*CGFloat(starNum-4)), y: Int(-backgroundScoreboardSprite.size.height*6/20))
            backgroundScoreboardSprite.addChild(starTemp)
            playerStars.append(starTemp)
        }
        // Label StarValue x5
        starValue = SKLabelNode.init(text: "5x=")
        starValue.fontName = "Avenir-Heavy"
        starValue.horizontalAlignmentMode = .left
        starValue.fontColor = .lightGray
        starValue.fontSize = 16
        starValue.zPosition = 4
        starValue.position = CGPoint(x: Int(-backgroundScoreboardSprite.size.width*7/20), y: Int(-backgroundScoreboardSprite.size.height*7/20))
        backgroundScoreboardSprite.addChild(starValue)
        // Fred Counter
        fredCount = SKLabelNode.init(text: "0")
        fredCount.fontName = "Avenir-Heavy"
        fredCount.horizontalAlignmentMode = .center
        fredCount.fontColor = .lightGray
        fredCount.fontSize = 24
        fredCount.zPosition = 4
        fredCount.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*6/40), y: Int(backgroundScoreboardSprite.size.height*4/20))
        backgroundScoreboardSprite.addChild(fredCount)
        // Player Counter
        playerCount = SKLabelNode.init(text: "0")
        playerCount.fontName = "Avenir-Heavy"
        playerCount.horizontalAlignmentMode = .center
        playerCount.fontColor = .lightGray
        playerCount.fontSize = 24
        playerCount.zPosition = 4
        playerCount.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*6/40), y: Int(-backgroundScoreboardSprite.size.height*2/20))
        backgroundScoreboardSprite.addChild(playerCount)
        // Score Title
        scoreTitle = SKLabelNode.init(text: "Score")
        scoreTitle.fontName = "Avenir"
        scoreTitle.horizontalAlignmentMode = .center
        scoreTitle.fontColor = .lightGray
        scoreTitle.fontSize = 20
        scoreTitle.zPosition = 4
        scoreTitle.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*14/40), y: Int(backgroundScoreboardSprite.size.height*6/20))
        backgroundScoreboardSprite.addChild(scoreTitle)
        // Score
        score = SKLabelNode.init(text: "0")
        score.fontName = "Avenir-Heavy"
        score.horizontalAlignmentMode = .center
        score.fontColor = .lightGray
        score.fontSize = 46
        score.zPosition = 4
        score.position = CGPoint(x: Int(backgroundScoreboardSprite.size.width*14/40), y: Int(-backgroundScoreboardSprite.size.height*2/20))
        backgroundScoreboardSprite.addChild(score)
    }
}
