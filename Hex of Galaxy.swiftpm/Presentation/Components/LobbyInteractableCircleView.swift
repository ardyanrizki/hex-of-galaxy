//
//  SwiftUIView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI


struct LobbyInteractableCircleView: View {
    @State var currentColor: Color = Color(hue: Double.random(in: 0...1), saturation: 1.0, brightness: 0.5)
    
    @State var hue: Double = 0.0
    @State var brightness: Double = 0.5
    @State var tolerance: Double = 0.25
    
    let circleSize: CGFloat = UIDevice.isIpad ? 320 : 220
    
    func gestureHandler(_ value: DragGesture.Value) {
        let step = 0.01
        
        // MARK: Hue
        var heightTranslation = value.translation.height / (-circleSize * 10)
        if heightTranslation > step { heightTranslation = step }
        if heightTranslation < -step { heightTranslation = -step }
        
        // MARK: Brightness
        var widthTranslation = value.translation.width / (-circleSize * 10)
        if widthTranslation > step { widthTranslation = step }
        if widthTranslation < -step { widthTranslation = -step }
        
        if abs(heightTranslation) > abs(widthTranslation) {
            let hue = heightTranslation + self.hue
            self.hue = hue > 1.0 ? hue - 1.0 : hue < 0 ? 1.0 - hue : hue
        } else {
            let brightness = -widthTranslation + self.brightness
            self.brightness = brightness > 1.0 ? 1.0 : brightness < 0 ? 0 : brightness
        }
        
        currentColor = Color(hue: hue, saturation: 1.0, brightness: brightness)
    }
    
    var body: some View {
        GestureCircleView(currentColor: $currentColor, circleSize: circleSize) { value in
            gestureHandler(value)
        }
    }
}


struct LobbyInteractableCircleView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyInteractableCircleView()
    }
}
