//
//  GameInstructionView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 11/04/23.
//

import SwiftUI

struct GameInstructionView: View {
    
    @State private var animationStart = false
    
    let showBackground: Bool
    
    init(showBackground: Bool = false) {
        self.showBackground = showBackground
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(alignment: .leading, spacing: UIDevice.isIpad ? 32 : 24) {
                ForEach(ResourceManager.instance.gameInstructions) { gameHelp in
                    GameInstructionItemView(gameHelp: gameHelp)
                }
            }
            .foregroundColor(Color(Constant.whiteColor))
            
            Text(Constant.gameInstructionFiveString)
                .foregroundColor(Color(Constant.whiteColor))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 32)
        }
        .frame(maxWidth: UIDevice.isIpad ? 500 : UIScreen.screenWidth - 54)
        .padding(.vertical, 40)
        .background {
            showBackground ? Color.black.opacity(0.6) : Color.clear
        }
        .cornerRadius(24)
    }
}

struct LobbyGameInstructionView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(spacing: UIDevice.isIpad ? 32 : 24) {
                ForEach(ResourceManager.instance.gameInstructions) { gameHelp in
                    GameInstructionItemView(gameHelp: gameHelp, size: .small)
                }
            }
            .foregroundColor(Color(Constant.whiteColor))
        }
        .frame(maxWidth: UIDevice.isIpad ? 500 : UIScreen.screenWidth - 54)
        .padding(40)
        .background {
            Color.black.opacity(0.6)
        }
        .cornerRadius(24)
    }
}

struct GameInstructionModalView: View {
    
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            GameInstructionView()
            
            Divider()
                .padding(.top, 32)
                .padding(.bottom, 8)
            
            Button {
                withAnimation(.interpolatingSpring(mass: 1, stiffness: 100, damping: 10, initialVelocity: 5)) {
                    isShown = false
                }
            } label: {
                Text(Constant.closeString)
                    .fontWeight(.medium)
                    .foregroundColor(Color.red)
            }
            
        }
        .padding(.horizontal, 18)
        .padding(.top, 40)
        .padding(.bottom, 24)
        .frame(maxWidth: UIDevice.isIpad ? 540 : UIScreen.screenWidth - 40)
        .background(.ultraThinMaterial)
        .cornerRadius(24)
    }
}

struct GameInstructionItemView: View {
    let gameHelp: GameInstruction
    let size: Size
    let iconSize: CGFloat
    let textSize: CGFloat
    
    init(gameHelp: GameInstruction, size: Size = .medium) {
        self.gameHelp = gameHelp
        self.size = size
        self.iconSize = UIDevice.isIpad ? (size == .medium ? 48 : 28) : (size == .small ? 24 : 20)
        self.textSize = UIDevice.isIpad ? (size == .medium ? 24 : 16) : (size == .small ? 20 : 16)
    }
    
    var body: some View {
        if size == .medium {
            HStack(spacing: 24) {
                Image(systemName: gameHelp.symbolName)
                    .font(.system(size: iconSize))
                    .frame(minWidth: UIDevice.isIpad ? 100 : 48)
                
                Text(gameHelp.text)
                    .font(.system(size: textSize, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
        } else {
            VStack(spacing: 24) {
                Image(systemName: gameHelp.symbolName)
                    .font(.system(size: iconSize))
                    .frame(minWidth: UIDevice.isIpad ? 100 : 48)
                
                Text(gameHelp.text)
                    .font(.system(size: textSize, weight: .medium))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    enum Size {
        case medium
        case small
    }
    
}

struct GameInstruction: Identifiable {
    let id: UUID = UUID()
    let symbolName: String
    let text: String
}
