//
//  PlayScreenViewModel.swift
//  Hex of Galaxy
//
//  Created by Muhammad Rizki Ardyan on 07/04/23.
//

import SwiftUI

class PlayScreenViewModel: ObservableObject {
    
    @Published var state: PlayScreenState = .intro
    @Published var playWildMode: Bool = true
    
    // MARK: Color related
    @Published var targetPlanet: Planet?
    @Published var currentColor = Color(hue: Double.random(in: 0...1), saturation: 1.0, brightness: 0.5)
    @Published var hue: Double = 0.0
    @Published var brightness: Double = 0.5
    @Published var tolerance: Double = 0.2
    
    // MARK: Timer related
    private let duration: Double = 15.0
    private var timer: ResumableTimer?
    
    @Published var remainingTime: Double = 0 {
        didSet {
            progress = (duration - remainingTime) / duration
        }
    }
    @Published var progress: Double = 0.0
    
    // MARK: User statistic related
    @Published var lives: Int = 5
    @Published var score: Int = 0
    
    // MARK: Game intro related
    @Published var notShowIntroMessageAgain: Bool = false
    
    var bestPlanet: BestPlanet?
    
    private var planets: [Planet] = [] {
        didSet {
            if !planets.isEmpty {
                targetPlanet = planets[stage]
            }
        }
    }
    private var stage: Int = 0 {
        didSet {
            if !planets.isEmpty {
                targetPlanet = planets[stage]
            }
        }
    }
    
    init() {
        checkIntroShowMessage()
        getPlanetsData()
        
        if state != .intro {
            state = .playing
            startGame()
        }
    }
    
    func startGameFromIntro() {
        if notShowIntroMessageAgain {
            setShowIntroMessageToFalse()
        }
        state = .playing
        startGame()
    }
    
    func startGame() {
        timer = ResumableTimer(duration: duration, handler: handleTimerTicking, completion: handleTimerComplete)
        startTimer()
        state = .playing
    }
    
    func pauseGame() {
        timer?.pauseTimer()
        state = .paused
    }
    
    func resumeGame() {
        timer?.resumeTimer()
        state = .playing
    }
    
    func stopGame() {
        stage = 0
        state = .gameOver
        timer?.resetTimer()
    }
    
    func checkAnswer(callback: (_ isCorrect: Bool) -> Void) {
        let userColor = HSBInDouble(hue: hue, saturation: planets[stage].hsbInDouble[0].saturation, brightness: brightness)
        if planets[stage].isColorMatch(with: userColor, tolerance: tolerance) {
            increaseScore()
            if stage < planets.count - 1 {
                resetGame()
            } else {
                stopGame()
            }
            callback(true)
        } else {
            decreaseLive()
            callback(false)
        }
    }
    
    func resetGame() {
        if stage < planets.count - 1 {
            stage += 1
            hue = Double.random(in: 0...1)
            brightness = 0.5
            currentColor = Color(hue: hue, saturation: planets[stage].hsbInDouble[0].saturation, brightness: brightness)
            startTimer()
        } else {
            stage = 0
            timer?.resetTimer()
        }
    }
    
    private func checkIntroShowMessage() {
        if UserDefaults.standard.bool(forKey: Constant.dontShowAgainKey) {
            state = .playing
        } else {
            state = .intro
        }
    }
    
    private func setShowIntroMessageToFalse() {
        UserDefaults.standard.set(true, forKey: Constant.dontShowAgainKey)
    }
    
    private func getPlanetsData() {
        planets = ResourceManager.instance.getPlanets().shuffled()
    }
    
    private func startTimer() {
        if let timer = timer, timer.isRunning {
            remainingTime = duration
            timer.resetTimer()
        }
        timer?.startTimer()
    }
    
    private func handleTimerTicking(_ elapsedTime: Double) {
        remainingTime = duration - elapsedTime
    }
    
    private func handleTimerComplete() {
        decreaseLive()
        guard lives != 0 else { return }
        resetGame()
    }
    
    private func decreaseLive() {
        guard lives > 0 else { return }
        lives = lives - 1
        if lives <= 0 {
            stopGame()
        }
    }
    
    private func increaseScore() {
        let planet = planets[stage]
        let additionalScore = Int(1000.0 * (remainingTime / duration))
        score += additionalScore
        // Check the best score
        guard let bestPlanet else {
            self.bestPlanet = BestPlanet(planet: planet, score: additionalScore)
            return
        }
        if bestPlanet.score < additionalScore {
            self.bestPlanet = BestPlanet(planet: planet, score: additionalScore)
        }
    }
}

enum PlayScreenState {
    case intro
    case loading
    case playing
    case paused
    case gameOver
}

struct BestPlanet {
    var planet: Planet
    var score: Int
}
