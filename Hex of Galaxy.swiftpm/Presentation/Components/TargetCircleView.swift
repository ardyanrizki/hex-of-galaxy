//
//  TargetCircleView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI

struct TargetCircleView: View {
    @EnvironmentObject var viewModel: PlayScreenViewModel
    
    @State private var scale: CGFloat = 1.0
    @State private var isShrink = true
    
    let circleSize: CGFloat
    
    var body: some View {
        ZStack {
            if viewModel.playWildMode {
                Image(viewModel.targetPlanet?.name ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: circleSize,
                           height: circleSize)
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0.0), value: scale)
                    .onChange(of: viewModel.remainingTime, perform: { time in
                        if Int(time) == 0 {
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 10.0, damping: 5.0, initialVelocity: 1.0)) {
                                self.scale = 1.0
                            }
                        } else if Int(time) % 2 == 0 {
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0.0)) {
                                self.scale = isShrink ? 0.6 : 1.0
                                isShrink.toggle()
                            }
                        }
                        
                    })
            } else {
                Circle()
                    .fill(viewModel.targetPlanet?.color[0] ?? Color(Constant.blackColor))
                    .frame(width: circleSize,
                           height: circleSize)
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0.0), value: scale)
                    .onChange(of: viewModel.remainingTime, perform: { time in
                        if Int(time) == 0 {
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 10.0, damping: 5.0, initialVelocity: 1.0)) {
                                self.scale = 1.0
                            }
                        } else if Int(time) % 2 == 0 {
                            withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10.0, initialVelocity: 0.0)) {
                                self.scale = isShrink ? 0.6 : 1.0
                                isShrink.toggle()
                            }
                        }
                        
                    })
            }
        }
    }
}
