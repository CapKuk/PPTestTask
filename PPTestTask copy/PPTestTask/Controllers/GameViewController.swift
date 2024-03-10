//
//  GameViewController.swift
//  PPTestTask
//
//  Created by user254109 on 3/8/24.
//

import Foundation
import SwiftUI

struct GameViewController {
    
    private var gameModel: GameModel = GameModel()
    /*@ObservedObject var gameObserver = GameObserver()
    
    init() {
        self.gameObserver.initController(gameController: self)
        self.gameObserver.checkGameStatus()
    }*/
    
    public func startGame() {
        gameModel.isGameAlive = true;
        gameModel.gameObjects.removeAll()
        gameModel.lifeCount = 5
        gameModel.score = 0
        gameModel.timer = 30
        gameModel.isPlayerWin = false
        gameModel.isPlayerLost = false
    }
    
    public func stopGame() {
        gameModel.isGameAlive = false
        gameModel.gameObjects.removeAll()
    }
    
    public func onCandyTap(gameObject: GameObject) {
        if (gameObject.gameObjectType == gameModel.candyType) {
            gameModel.score += 1
            changeObjectType()
        }
        else {
            gameModel.lifeCount -= 1
        }
        
        if (gameModel.lifeCount <= 0) {
            gameModel.isGameAlive = false
            gameModel.isPlayerLost = true
        }
        
        if (gameModel.score >= 5) {
            gameModel.isPlayerWin = true
            gameModel.isGameAlive = false
        }
    }
    
    private func changeObjectType() {
        let allCandyTypes: [CandyTypes] = [.candy, .grape, .gum]

        let availableCandyTypes = allCandyTypes.filter { $0 != gameModel.candyType }

        if let newType = availableCandyTypes.randomElement() {
            gameModel.candyType = newType
        }
    }
    
    public func getScore() -> Int {
        return gameModel.score
    }
    
    public func getLife() -> Int {
        return gameModel.lifeCount
    }
    
    public func getCandyType() -> String {
        switch gameModel.candyType {
        case .grape:
            return "Grape"
        case .candy:
            return "Candy"
        case .gum:
            return "Gum"
        }
    }
    
    public func getGameObjects() -> [GameObject] {
        return gameModel.gameObjects
    }
    
    public func removeGameObject(index: Int) {
        gameModel.gameObjects.remove(at: index)
    }
    
    public func appendGameObect(gameObject: GameObject) {
        gameModel.gameObjects.append(gameObject)
    }
    
    public func getTimer() -> Int {
        return gameModel.timer
    }
    
    public func isGameAlive() -> Bool {
        return gameModel.isGameAlive
    }
    
    public func isPlayerWin() -> Bool {
        return gameModel.isPlayerWin
    }
    
    public func isPlayerLost() -> Bool {
        return gameModel.isPlayerLost
    }
    
    public func timeIsUp() {
        gameModel.isGameAlive = false
        gameModel.isPlayerLost = true
    }
}
