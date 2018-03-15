//
//  FredStates.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/12/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredState: GKState {
    
    let game: GameScene
    let associatedStateName: String
    
    var associatedStateTexture: SKTexture? {
        switch self.associatedStateName {
            case "ReadyToPlay":
                return game.scoreboard.state1Texture
            case "FredAddsRandomButton":
                return game.scoreboard.state2Texture
            case "FredPlayingSequence":
                return game.scoreboard.state3Texture
            case "FredPressButton":
                return game.scoreboard.state3Texture
            case "FredReleaseButton":
                return game.scoreboard.state3Texture
            case "PlayerPlayingSequence":
                return game.scoreboard.state4Texture
            case "WaitingForPlayer":
                return game.scoreboard.state4Texture
            case "PlayerPressButton":
                return game.scoreboard.state4Texture
            case "PlayerReleaseButton":
                return game.scoreboard.state4Texture
            case "GameOver":
                return game.scoreboard.state1Texture
            default:
                print("Not listed state, assuming state 1: 'ReadyToPlay'")
                return game.scoreboard.state1Texture
        }
    }
    
    init(game: GameScene, associatedStateName: String) {
        self.game = game
        self.associatedStateName = associatedStateName
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let associatedTexture = associatedStateTexture else { return }
        print("Entering state: \(associatedStateName)")
        game.scoreboard.stateSprint.texture = associatedTexture
    }
    
    override func willExit(to nextState: GKState) {
        print("Exiting state: \(associatedStateName)")
    }
}

//class ReadyToStartPlay: FredState {
//
//    required init(game: GameScene) {
//        super.init(game: game, associatedStateName: "ReadyToStartPlay")
//    }
//
//    override func didEnter(from previousState: GKState?) {
//        super.didEnter(from: previousState)
//        // Enable Start Button
//        game.startButton.startButtonSprite.texture = game.startButton.startOnTexture
//        game.startButton.startLabel.text = "Press to Play"
//    }
//
//    override func willExit(to nextState: GKState) {
//        super.willExit(to: nextState)
//        // Reset variables to Start Game
//        game.counterToNextAction = 30
//        game.sequenceCounter = 0
//        game.sequenceList.removeAll()
//        game.cycles = 0
//        game.score = 0
//        // Labels and textures set to Start Game
//        game.startButton.startButtonSprite.texture = game.startButton.startOffTexture
//        game.startButton.startLabel.text = "Playing"
//        game.scoreboard.fredLabel.fontColor = .gray
//        game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOff
//        game.scoreboard.fredNew.texture = game.scoreboard.fredNewOff
//        game.scoreboard.fredCount.text = "0"
//        game.scoreboard.playerLabel.fontColor = .gray
//        game.scoreboard.playerCorrect.texture = game.scoreboard.playerCorrectOff
//        game.scoreboard.playerError.texture = game.scoreboard.playerErrorOff
//        game.scoreboard.playerCount.text = "0"
//        game.scoreboard.score.text = "0"
//        for i in 1...10 {
//            game.scoreboard.playerStars[i-1].texture = game.scoreboard.starOff
//        }
//    }
//
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is FredPlaySequence.Type
//    }
//}
//
//
//class FredPlaySequence: FredState {
//
//    required init(game: GameScene) {
//        super.init(game: game, associatedStateName: "FredPlaySequence")
//    }
//
//    override func didEnter(from previousState: GKState?) {
//        super.didEnter(from: previousState)
//        // Labels and textures set for FredPlaySequence
//        game.scoreboard.fredLabel.fontColor = .blue
//        game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOn
//        game.scoreboard.fredCount.text = "0"
//        if (game.sequenceList.isEmpty) {
//            let stateStatus = game.stateFredMachine.enter(FredAddNewColor.self)
//            if !stateStatus { print("Error 2") }
//        }
//    }
//
//    override func willExit(to nextState: GKState) {
//        super.willExit(to: nextState)
//        // Labels and textures set before exit FredPlaySequence
//        game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOff
//        game.scoreboard.fredNew.texture = game.scoreboard.fredNewOn
//    }
//
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is FredAddNewColor.Type
//    }
//}
//
//class FredAddNewColor: FredState {
//
//    required init(game: GameScene) {
//        super.init(game: game, associatedStateName: "FredAddNewColor")
//    }
//
//    override func didEnter(from previousState: GKState?) {
//        super.didEnter(from: previousState)
//        // New Value added to array and play sound
//        game.sequenceList.append(game.newValue.nextInt())
//        let value = game.sequenceList[game.sequenceCounter]
//        game.sequenceCounter += 1
//        game.scoreboard.fredCount.text = "\(game.sequenceCounter)"
//        game.idButtonPlaying = value
//        game.counterToNextAction = 30
//        game.fredButtons[value-1].buttonSprite.run(game.fredButtons[value-1].pressButtonAction)
//    }
//
//    override func willExit(to nextState: GKState) {
//        super.willExit(to: nextState)
//        // Set variables
//        game.counterToNextAction = 90
//        game.sequenceCounter = 0
//        // Set Labels and textures
//        game.scoreboard.fredLabel.fontColor = .gray
//        game.scoreboard.fredNew.texture = game.scoreboard.fredNewOff
//        game.scoreboard.playerLabel.fontColor = .blue
//        game.scoreboard.playerCount.text = "0"
//    }
//
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is PlayerRepeatSequence.Type
//    }
//}
//
//class PlayerRepeatSequence: FredState {
//
//    required init(game: GameScene) {
//        super.init(game: game, associatedStateName: "PlayerRepeatSequence")
//    }
//
//    override func didEnter(from previousState: GKState?) {
//        super.didEnter(from: previousState)
//        // Reset variables to Start Game
//        game.counterToNextAction = 200
//        game.sequenceCounter = 0
//    }
//
//    override func willExit(to nextState: GKState) {
//        super.willExit(to: nextState)
//        if nextState is FredAddNewColor {
//            game.cycles += 1
//            game.scoreboard.playerStars[game.cycles-1].texture = game.scoreboard.starOn
//            game.scoreboard.playerLabel.fontColor = .gray
//            game.sequenceCounter = 0
//            game.counterToNextAction = 30
//        }
//        if nextState is WrongColorGameOver {
//            //
//
//        }
//    }
//
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//
//        switch stateClass {
//        case is FredPlaySequence.Type, is WrongColorGameOver.Type:
//            return true
//        default:
//            return false
//        }
//    }
//}
//
//class WrongColorGameOver: FredState {
//
//    required init(game: GameScene) {
//        super.init(game: game, associatedStateName: "WrongColorGameOver")
//    }
//
//    override func didEnter(from previousState: GKState?) {
//        super.didEnter(from: previousState)
//        print("***** Game Over *****")
//
//
//        // TODO: Game Over
//        game.startButton.startLabel.text = "GAME OVER"
//        game.startButton.startLabel.fontColor = .red
//        game.run(SKAction.wait(forDuration: 5.0),
//            completion: {
//                let stateStatus = self.game.stateFredMachine.enter(ReadyToStartPlay.self)
//                if !stateStatus { print("Error 1") }
//            }
//        )
//
////        toneGenerator.startPlaying(140.0)
//
//    }
//
//    override func willExit(to nextState: GKState) {
//        super.willExit(to: nextState)
//        game.scoreboard.playerError.texture = game.scoreboard.playerErrorOff
//        game.scoreboard.playerLabel.fontColor = .gray
//    }
//
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        return stateClass is ReadyToStartPlay.Type
//    }
//}
