//
//  Model.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 13/04/23.
//

import SwiftUI

// MARK: Planet related
struct Planet: Decodable {
    let order: Int
    let name: String
    let hsb: [HSB]
    let hex: [String]
    let headline: String
    let trivia: String
    
    var color: [Color] {
        hsb.map { Color(hue: Double($0.h) / 360, saturation: Double($0.s) / 100, brightness: Double($0.b) / 100) }
    }
    var hsbInDouble: [HSBInDouble] {
        hsb.map { HSBInDouble(hue: Double($0.h) / 360, saturation: Double($0.s) / 100, brightness: Double($0.b) / 100) }
    }
    
    func isColorMatch(with userHSB: HSBInDouble, tolerance: Double = 0.2) -> Bool {
        var targetHue: CGFloat = 0.0
        var targetBrightness: CGFloat = 0.0
        var currentHue: CGFloat = 0.0
        var currentBrightness: CGFloat = 0.0
        
        let userColor: Color = Color(hue: userHSB.hue, saturation: userHSB.saturation, brightness: userHSB.brightness)
        
        var anyMatch = false
        
        color.forEach { col in
            let _ = UIColor(col).getHue(&targetHue, saturation: nil, brightness: &targetBrightness, alpha: nil)
            let _ = UIColor(userColor).getHue(&currentHue, saturation: nil, brightness: &currentBrightness, alpha: nil)
            
            if abs(Double(targetHue) - userHSB.hue) < tolerance && abs(Double(targetBrightness) - userHSB.brightness) < tolerance {
                anyMatch = true
            }
        }
        return anyMatch
    }
}

// MARK: Color related
struct HSB: Decodable {
    let h: Int
    let s: Int
    let b: Int
}

struct HSBInDouble {
    let hue: Double
    let saturation: Double
    let brightness: Double
}

// MARK: Credit related
struct Credit: Decodable, Identifiable {
    var id: UUID { UUID() }
    let category: String
    let list: [CreditItem]
}

struct CreditItem: Decodable, Identifiable {
    var id: UUID { UUID() }
    let title: String
    let linkLabel: String
    let url: String
}
