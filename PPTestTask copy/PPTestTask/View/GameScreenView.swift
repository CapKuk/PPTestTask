//
//  ContentView.swift
//  PPTestTask
//
//  Created by user254109 on 3/5/24.
//

import SwiftUI

struct GameView: View {
    
    private let gameObjetSize:CGSize = CGSize(width: 50, height: 50)
    
    private var gameController: GameViewController = GameViewController()
    
    @State private var isGameAlive: Bool = false
    @State private var gameObjects: [GameObject] = []
    @State private var isPlayerWin: Bool = false
    @State private var isPlayerLost: Bool = false
    @State private var time: Int = 30
    @State private var isTimerRunning: Bool = false
    
    
    var body: some View {
        ZStack {
            Image("baackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Score \(gameController.getScore())")
                    .font(.title)
                
                Text("\(gameController.getCandyType())")
                    .font(.title)
                
                Text("Life \(gameController.getLife())")
                    .font(.title)
                
                if isPlayerWin {
                    Text("You Won!")
                        .font(.title)
                }
                
                if isPlayerLost {
                    Text("You Lose!")
                        .font(.title)
                }
                
                Text("Time: \(time)")
                    .font(.title)
                    .foregroundColor(time <= 10 ? .red : .black)
                
                if !isGameAlive {
                    Button(action: {
                        startGame()
                    }, label: {
                        Text("Restart")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                    })
                }
                
                Spacer()
                
                ZStack {
                    ForEach(gameController.getGameObjects()) {
                        object in GameObjectView(object: object)
                            .offset(object.offset)
                    }
                    
                    ForEach(gameObjects.indices, id: \.self) { index in
                        if gameObjects.indices.contains(index) {
                            GameObjectView(object: gameObjects[index])
                                .offset(gameObjects[index].offset)
                                .background(
                                    GeometryReader { geometry in
                                        Color.clear.onAppear {
                                            if gameObjects[index].offset.height >   geometry.size.height {
                                                gameObjects.remove(at: index)
                                            }
                                        }
                                    }
                                )
                                .onTapGesture {
                                    gameController.onCandyTap(gameObject: gameObjects[index])
                                    gameObjects.remove(at: index)
                                }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 10)
            
        }
    }
    
    func startTimer() {
        if !isTimerRunning {
            time = 30
            isTimerRunning = true
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
                if time > 0 && isGameAlive {
                    time -= 1
                } else {
                    timer.invalidate()
                    isTimerRunning = false
                    gameController.timeIsUp()
                }
            }
        }
    }
    
    func startGame() {
        gameController.startGame()
        startTimer()
        
        gameObjects.removeAll()
        isPlayerWin = gameController.isPlayerWin()
        isPlayerLost = gameController.isPlayerLost()
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {timer in
            isGameAlive = gameController.isGameAlive()
            if (isGameAlive) {
                    let randomX = CGFloat.random(in: -(UIScreen.main.bounds.width/2 - gameObjetSize.width)...(UIScreen.main.bounds.width/2 - gameObjetSize.width))
                    
                    let randomObjectType = Int.random(in: 0...2)
                    var objectType: CandyTypes
                    switch randomObjectType {
                    case 0: objectType = .candy
                        break
                    case 1: objectType = .grape
                        break
                    case 2: objectType = .gum
                        break
                    default:
                        objectType = .candy
                        break
                    }
                    
                let newObject = GameObject(gameObjectType: objectType, offset: CGSize(width: randomX, height: -gameObjetSize.height - UIScreen.main.bounds.height/4))
                    
                    gameObjects.append(newObject)
                
                withAnimation(.linear(duration: 5)) {
                    gameObjects.forEach {
                        $0.offset.height += gameObjetSize.height
                    }
                }
            }
            else {
                gameObjects.removeAll()
                isPlayerWin = gameController.isPlayerWin()
                isPlayerLost = gameController.isPlayerLost()
                timer.invalidate()
            }
        }
    }
}

#Preview {
    GameView()
}

struct GameObjectView: View {
    let object: GameObject
    
    var body: some View {
        let imageName: String
               
        switch object.gameObjectType {
            case .candy:
                imageName = "Candy"
            case .grape:
                imageName = "Grape"
            case .gum:
                imageName = "Gum"
        }
               
        return Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}
