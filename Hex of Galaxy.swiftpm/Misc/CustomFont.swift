//
//  CustomFont.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 07/04/23.
//

import SwiftUI

struct CustomFont {
    
    private init() {
        let fontURL = Bundle.main.url(forResource: "PressStart2P-Regular", withExtension: "ttf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
    }
    
    static let shared = CustomFont()
    
    func pressStart2P(size: CGFloat = 24) -> UIFont {
        return UIFont(name: "PressStart2P-Regular", size: size)!
    }
}
