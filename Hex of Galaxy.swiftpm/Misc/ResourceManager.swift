//
//  ResourceManager.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 17/04/23.
//

import Foundation

class ResourceManager {
    private init() {}
    
    static let instance: ResourceManager = ResourceManager()
    
    func getPlanets() -> [Planet] {
        guard let fileURL = Bundle.main.url(forResource: "planets", withExtension: ".json") else { return [] }
        guard let data = try? Data(contentsOf: fileURL)  else { return [] }
        let planet = try? JSONDecoder().decode([Planet].self, from: data)
        return planet ?? []
    }
    
    func getCredits() -> [Credit] {
        guard let fileURL = Bundle.main.url(forResource: "credits", withExtension: ".json") else { return [] }
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        return (try? JSONDecoder().decode([Credit].self, from: data)) ?? []
    }
    
    let gameInstructions = [
        GameInstruction(symbolName: Constant.arrowUpDownSF, text: Constant.gameInstructionOneString),
        GameInstruction(symbolName: Constant.arrowLeftRightSF, text: Constant.gameInstructionTwoString),
        GameInstruction(symbolName: Constant.handTapSF, text: Constant.gameInstructionThreeString)
    ]
}
