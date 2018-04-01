//
//  GameData.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/24/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

class GameData {
	
	static let shared = GameData()
	
	private init() {
		
		// TODO: Restore from file, if does't exist create it with standard values
		
	}
	
	/// Configuration values
	var framesDelayedRelease: Int = 9
	var framesBetweenCycles: Int = 36
	var framesButtonAnimation: Int  = 21
	var framesBetweenTurns: Int  = 9
	var framesPlayerWaiting: Int  = 180
}
