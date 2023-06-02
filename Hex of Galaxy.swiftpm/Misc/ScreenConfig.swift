//
//  UIScreen+Extension.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 09/04/23.
//

import SwiftUI

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

extension UIDevice {
    static var isIpad: Bool { UIDevice.current.localizedModel == "iPad" }
    static var isLandscape: Bool { UIDevice.current.orientation.isLandscape }
}
