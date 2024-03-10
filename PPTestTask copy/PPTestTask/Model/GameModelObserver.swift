//
//  GameModelObserver.swift
//  PPTestTask
//
//  Created by user254109 on 3/9/24.
//

import Foundation

class GameObserver: ObservableObject {
    @Published var isGameAlive: Bool = false
    private var gameController: GameViewController?
    
    public func initController(gameController: GameViewController) {
        self.gameController = gameController
    }
    
    func checkGameStatus() {
        if (gameController != nil) {
            if (gameController!.isGameAlive()) {
                isGameAlive = true
            } else {
                isGameAlive = false
            }
        }
    }
}
