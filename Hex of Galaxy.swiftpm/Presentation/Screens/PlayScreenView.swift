//
//  PlayScreenView.swift
//  Hex of Galaxy
//
//  Created by Muhammad Rizki Ardyan on 07/04/23.
//

import SwiftUI

struct PlayScreenView: View {
    
    @ObservedObject var viewModel = PlayScreenViewModel()
    
    @State var answerPromptState: AnswerPromptToastView.State = .hidden {
        didSet {
            if answerPromptState != .hidden {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 5)) {
                        answerPromptState = .hidden
                    }
                }
            }
        }
    }
    
    @State var isShowGameInstruction: Bool = false
    @Binding var isPlayScreenActive: Bool
    
    let interactableCircleSize: CGFloat = UIDevice.isIpad ? (UIDevice.isLandscape ? 320 : 420) : UIScreen.screenWidth - 140
    let targetCircleSize: CGFloat = UIDevice.isIpad ? (UIDevice.isLandscape ? 220 : 320) : UIScreen.screenWidth - 180
    let progressBarWidth: CGFloat = UIDevice.isIpad ? 10.0 : 6.0
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                PlayerStatsView(lives: viewModel.lives, score: viewModel.score)
                
                Spacer()
                
                VStack(spacing: UIDevice.isIpad ? 40 : 24) {
                    Text(viewModel.targetPlanet?.headline ?? "")
                        .font(Font(CustomFont.shared.pressStart2P(size: UIDevice.isIpad ? 20 : 14)))
                        .lineSpacing(12.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color(Constant.primaryColor))
                        .padding(.bottom, UIDevice.isIpad ? 24 : 16)
                        .frame(height: 40)
                    
                    if UIDevice.isLandscape {
                        HStack(spacing: UIDevice.isIpad ? 40 : 24) {
                            TargetCircleView(circleSize: targetCircleSize)
                                .environmentObject(viewModel)
                            //                    Text("H: \(viewModel.hue) | B: \(viewModel.brightness)")
                            
                            InteractableCircleView(progressBarWidth: progressBarWidth, circleSize: interactableCircleSize) {
                                viewModel.checkAnswer { isCorrect in
                                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 5)) {
                                        answerPromptState = isCorrect ? .correct : .wrong
                                    }
                                }
                            }
                            .environmentObject(viewModel)
                            
                        }
                    } else {
                        VStack(spacing: UIDevice.isIpad ? 40 : 24) {
                            TargetCircleView(circleSize: targetCircleSize)
                                .environmentObject(viewModel)
                            InteractableCircleView(progressBarWidth: progressBarWidth, circleSize: interactableCircleSize) {
                                viewModel.checkAnswer { isCorrect in
                                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 5)) {
                                        answerPromptState = isCorrect ? .correct : .wrong
                                    }
                                }
                            }
                            .environmentObject(viewModel)
                        }
                    }
                }
                
                Spacer()
                
                
                HStack {
                    Button {
                        guard viewModel.state != .gameOver else { return }
                        withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 5)) {
                            isShowGameInstruction.toggle()
                        }
                    } label: {
                        Image(systemName: Constant.questionMarkSF)
                            .font(.system(size: UIDevice.isIpad ? 48 : 32))
                            .foregroundColor(Color(Constant.primaryColor))
                    }
                    
                    Spacer()
                    
                    Toggle(isOn: $viewModel.playWildMode) {
                        Image(systemName: viewModel.playWildMode ? Constant.boltFillSF : Constant.boltSlashFillSF)
                            .font(.system(size: UIDevice.isIpad ? 32 : 24, weight: .medium))
                        Text(Constant.wildMode)
                            .font(.system(size: UIDevice.isIpad ? 24 : 16, weight: .medium))
                    }
                    .toggleStyle(.button)
                    .foregroundColor(Color(Constant.primaryColor))
                    .tint(Color(Constant.primaryColor))
                }
            }
            .padding()
            .onChange(of: isShowGameInstruction) { value in
                if isShowGameInstruction {
                    viewModel.pauseGame()
                } else {
                    viewModel.resumeGame()
                }
            }
            
            // MARK: Modals
            if viewModel.state == .intro {
                GameIntroView(notShowAgain: $viewModel.notShowIntroMessageAgain)
                    .environmentObject(viewModel)
            }
                
                
            if answerPromptState != .hidden, viewModel.state == .playing {
                AnswerPromptToastView(state: answerPromptState)
                    .transition(.scale(scale: 0.4).combined(with: .opacity))
                    .zIndex(2)
            }
            
            if isShowGameInstruction {
                GameInstructionModalView(isShown: $isShowGameInstruction)
                    .transition(.scale(scale: 0.4).combined(with: .opacity))
                    .zIndex(2)
            }
            
            if viewModel.state == .gameOver {
                GameOverModalView(score: viewModel.score, bestPlanet: viewModel.bestPlanet, isPlayScreenActive: $isPlayScreenActive)
                    .transition(.scale(scale: 0.4).combined(with: .opacity))
                    .zIndex(2)
            }
        }
    }
}

struct PlayScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PlayScreenView(isPlayScreenActive: .constant(true))
    }
}
