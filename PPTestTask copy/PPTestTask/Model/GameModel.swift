//
//  GameModel.swift
//  PPTestTask
//
//  Created by user254109 on 3/9/24.
//

import Foundation

class GameModel: ObservableObject {
    @Published var score: Int = 0
    @Published var candyType: CandyTypes = .candy
    @Published var lifeCount: Int = 5
    @Published var timer: Int = 30
    public var isGameAlive: Bool = false
    @Published var isPlayerWin = false
    @Published var isPlayerLost = false
    
    @Published var gameObjects: [GameObject] = []
}
