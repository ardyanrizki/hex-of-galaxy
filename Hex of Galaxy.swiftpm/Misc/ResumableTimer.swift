//
//  ResumableTimer.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 11/04/23.
//

import Foundation

class ResumableTimer {
    var timer: Timer?
    var isRunning: Bool {
        return timer != nil && timer!.isValid
    }
    var isPaused: Bool = false
    var elapsedTime: Double = 0.0
    
    var duration: Double
    var interval: Double
    var handler: (Double) -> Void
    var completion: (() -> Void)?
    
    init(duration: Double, interval: Double = 0.1, handler: @escaping (Double) -> Void, completion: (() -> Void)? = nil) {
        self.duration = duration
        self.interval = interval
        self.handler = handler
        self.completion = completion
    }
    
    func startTimer() {
        resetTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            
            guard let self else { return }
            
            self.intervalHandler()
            self.handler(self.elapsedTime)
            
            if self.elapsedTime > self.duration, let completion = self.completion {
                self.timer?.invalidate()
                completion()
            }
        }
    }
    
    func intervalHandler() {
        if isPaused == false {
            self.elapsedTime += self.interval
        }
    }
    
    func pauseTimer() {
        isPaused = true
    }
    
    func resumeTimer() {
        isPaused = false
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        elapsedTime = 0.0
        isPaused = false
    }
}
