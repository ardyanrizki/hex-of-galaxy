//
//  InteractableCircleView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI

struct InteractableCircleView: View {
    
    @EnvironmentObject var viewModel: PlayScreenViewModel
    
    let progressBarWidth: CGFloat
    let circleSize: CGFloat
    let onTap: () -> Void
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .stroke(
                        Color.white,
                        lineWidth: progressBarWidth
                    )
                Circle()
                    .trim(from: 0.0, to: viewModel.progress)
                    .stroke(
                        Color.red,
                        style: StrokeStyle(lineWidth: progressBarWidth, lineCap: .round, lineJoin: .round))
                
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: viewModel.progress)
            }
            .frame(width: circleSize + progressBarWidth, height: circleSize + progressBarWidth)
            
            GestureCircleView(currentColor: $viewModel.currentColor, circleSize: circleSize) { value in
                guard viewModel.state == .playing else { return }
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
                    let hue = heightTranslation + viewModel.hue
                    viewModel.hue = hue > 1.0 ? hue - 1.0 : hue < 0 ? 1.0 - hue : hue
                } else {
                    let brightness = -widthTranslation + viewModel.brightness
                    viewModel.brightness = brightness > 1.0 ? 1.0 : brightness < 0 ? 0 : brightness
                }
                
                viewModel.currentColor = Color(hue: viewModel.hue, saturation: 1.0, brightness: viewModel.brightness)
            }
            .onTapGesture(count: 2) {
                onTap()
            }
        }
        .padding()
    }
}
