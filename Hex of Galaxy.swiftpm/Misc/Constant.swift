//
//  Constant.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 12/04/23.
//

import Foundation

struct Constant {
    // MARK: Colors
    static let primaryColor = "Primary"
    static let primaryShadeColor = "PrimaryShade"
    static let blackColor = "TextBlack"
    static let whiteColor = "TextWhite"
    
    // MARK: Images
    static let backgroundImage = "Background"
    static let coinImage = "Coin"
    static let logoImage = "Logo"
    static let heartImage = "Red heart"
    
    static let mercury = "Mercury"
    static let venus = "Venus"
    static let earth = "Earth"
    static let mars = "Mars"
    static let jupiter = "Jupiter"
    static let saturn = "Saturn"
    static let uranus = "Uranus"
    static let neptune = "Neptune"
    static let moon = "Moon"
    
    // MARK: Symbols
    static let arrowLeftRightSF = "arrow.left.arrow.right"
    static let arrowUpDownSF = "arrow.up.arrow.down"
    static let handTapSF = "hand.tap"
    static let questionMarkSF = "questionmark.circle.fill"
    static let boltFillSF = "bolt.fill"
    static let boltSlashFillSF = "bolt.slash.fill"
    static let checkmarkSF = "checkmark"
    
    // MARK: Strings
    static let matchColorOfThePlanets = "Match color of the planets"
    static let gameInstructionOneString = "Swipe up / down to change Hue"
    static let gameInstructionTwoString = "Swipe left / right to change Brightness"
    static let gameInstructionThreeString = "Double-tap to submit your answer"
    static let gameInstructionFiveString = "Your goal is to match the color of the planets while having five lives. Faster for the best result"
    
    static let correctPromptToast = "Good, that’s the one"
    static let wrongPromptToast = "Oops, incorrect!"
    static let wildMode = "Wild mode?"
    
    static let closeString = "Close"
    static let backToLobbyString = "Back to Lobby"
    static let playString = "Start"
    static let credits = "Credits"
    
    static let dontShowMessageAgain = "Don't show this message again"
    static let introButtonText = "Roger, soldier!"
    
    static let yourMissionOver = "Your mission over with score:"
    static let planetYouConquered = "The planet you conquered:"
    
    static let gameIntro = """
                Welcome to the mission, Captain!

                The objective of this mission is to match the color of the big circle with the color of the planet given to you.
                
                You can interact with the big circle by swiping up and down to adjust the hue and swiping left and right to adjust the brightness. When you think you have the correct color, tap the big circle twice to submit your answer.

                You will start the mission with 5 lives. Lives will be deducted each time you run out of time or answer incorrectly. The faster you answer correctly, the higher your score will be.
                
                If you require any assistance during the game, simply tap the question mark (?) icon located at the bottom left corner of your screen.

                At the end of the mission, you will receive a spirit planet based on your highest score. Good luck, Captain!
                """
    
    // MARK: User Defaults Key
    static let dontShowAgainKey = "dontShowAgainKey"
}

enum PlanetName: String {
    case mercury = "Mercury"
    case venus = "Venus"
    case earth = "Earth"
    case mars = "Mars"
    case jupiter = "Jupiter"
    case saturn = "Saturn"
    case uranus = "Uranus"
    case neptune = "Neptune"
    case moon = "Moon"
}
