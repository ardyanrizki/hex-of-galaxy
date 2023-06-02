//
//  GestureCircleView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI

struct GestureCircleView: View {
    @Binding var currentColor: Color
    let circleSize: CGFloat
    
    let gestureHandler: (DragGesture.Value) -> Void
    
    
    var body: some View {
        Circle()
            .fill(currentColor)
            .frame(width: circleSize, height: circleSize)
            .gesture(
                DragGesture(minimumDistance: 15, coordinateSpace: .local)
                    .onChanged { value in
                        gestureHandler(value)
                    }
            )
    }
}
