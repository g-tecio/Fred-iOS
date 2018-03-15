//
//  GameScene.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // State Game Machine
    var stateFredMachine: GKStateMachine!
    
    /// Keeps track of the time for use in the update method.
    var previousUpdateTime: TimeInterval = 0
    
    // Buttons
    var fredButtons: [Button] = []
    var idButtonPlaying: Int = 0
    var isSoundEnding: Bool = false
    
    // Start Button
    var startButton: StartButton!
    
    // Scoreboard
    var scoreboard: Scoreboard!
    
    // Game Over message
    var gameOverMessage: GameOverMessage!
    
    // Game variables
    var sequenceCounter:Int = 0
    var sequenceList:[Int] = []
    var cycles: Int = 0
    var score: Int = 0
    
    let newValue = GKRandomDistribution(lowestValue: 1, highestValue: 12)
 
    override func didMove(to view: SKView) {
        // Fred Buttons
        for button in 01...12 {
            fredButtons.append(Button.init(idButton: button, inThisScene: self))
        }
        // Scoreboard
        scoreboard = Scoreboard.init(inThisScene: self)
        // Startbutton
        startButton = StartButton.init(inThisScene: self)
        // Game Over
        gameOverMessage = GameOverMessage.init(inThisScene: self)
        // Creates and adds states to the dispenser's state machine.
        stateFredMachine = GKStateMachine(states: [     ReadyToPlay(game: self),
                                                        FredAddsRandomButton(game: self),
                                                        FredPlayingSequence(game: self),
                                                        FredPressButton(game: self),
                                                        FredReleaseButton(game: self),
                                                        PlayerPlayingSequence(game: self),
                                                        WaitingForPlayer(game: self),
                                                        PlayerPressButton(game: self),
                                                        PlayerReleaseButton(game: self),
                                                        GameOver(game: self)
                                                    ])
        // Tells the state machine to enter the ReadyToPlay state
        if !(stateFredMachine.enter(ReadyToPlay.self)) {
            print("Error 0")
        }
    }
    
    func releaseButtonFunction() {
        isSoundEnding = true
        fredButtons[idButtonPlaying-1].buttonSprite.run(
            fredButtons[idButtonPlaying-1].releaseButtonAction, completion: {
//                self.idButtonPlaying = 0
                self.isSoundEnding = false
        }
        )
    }
    
    func pressButtonFunction(buttonId: Int) {
        idButtonPlaying = buttonId
        fredButtons[idButtonPlaying-1].buttonSprite.run(fredButtons[idButtonPlaying-1].pressButtonAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Calculate the time change since the previous update.
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
    
        // The following states use the update: FredPressButton, FredReleaseButton and WaitingForPlayer
        stateFredMachine.update(deltaTime: timeSincePreviousUpdate)
        
        // Set previousUpdateTime to the current time, so the next update has accurate information
        previousUpdateTime = currentTime
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let item = atPoint(location)
            
            // Dismiss Game Over Message
             if (stateFredMachine.currentState is GameOver) {
                let gameOverLabel = childNode(withName: "//gameOverLabel")!
                if (gameOverLabel === item) {
                    if !stateFredMachine.enter(ReadyToPlay.self) {
                        print("Error 1")
                    }
                }
            }
            
            // Start Play Button
            if (stateFredMachine.currentState is ReadyToPlay) {
                let startButton = childNode(withName: "//startButton")!
                let startLabel = childNode(withName: "//startLabel")!

                if (startButton === item) || (startLabel === item){
                    if !stateFredMachine.enter(FredAddsRandomButton.self) {
                        print("Error 2")
                    }
                }
                // Allowed to play buttons when ReadyToPlay state, no effect on Game
                else {
                    for n in 1...12 {
//                        if (fredButtons[n-1].buttonSprite === item) && (idButtonPlaying == 0) {
                        if (fredButtons[n-1].buttonSprite === item) {
                            pressButtonFunction(buttonId: n)
                        }
                    }
                }
            }
            
            // Waiting for Player
            if (stateFredMachine.currentState is WaitingForPlayer) {
                for n in 1...12 {
                    if (fredButtons[n-1].buttonSprite === item) {
                        idButtonPlaying = n
                        // State change to PlayerPressButton
                        if !stateFredMachine.enter(PlayerPressButton.self) {
                            print("Error 3")
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (stateFredMachine.currentState is ReadyToPlay) {
            if (idButtonPlaying != 0) && (isSoundEnding == false) {
                releaseButtonFunction()
            }
        }
        if (stateFredMachine.currentState is PlayerPressButton) {
            releaseButtonFunction()
            if !stateFredMachine.enter(PlayerReleaseButton.self) {
                print("Error 4")
            }
        }
        
    }
    
}
