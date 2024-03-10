//
//  GameObject.swift
//  PPTestTask
//
//  Created by user254109 on 3/6/24.
//

import Foundation

public class GameObject : Identifiable, ObservableObject {
    public var id = UUID()
    @Published var offset: CGSize
    public var gameObjectType: CandyTypes
    
    init(id: UUID = UUID(), gameObjectType: CandyTypes, offset: CGSize) {
        self.gameObjectType = gameObjectType
        self.offset = offset
    }
}
