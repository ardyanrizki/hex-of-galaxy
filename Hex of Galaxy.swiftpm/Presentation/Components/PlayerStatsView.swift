//
//  PlayerStatsView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI


struct PlayerStatsView: View {
    let lives: Int
    let score: Int
    
    var body: some View {
        HStack {
            HStack(spacing: UIDevice.isIpad ? 16 : 12) {
                Image(Constant.coinImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIDevice.isIpad ? 44 : 24, height: UIDevice.isIpad ? 44 : 24)
                
                Text(String(score))
                    .font(Font(CustomFont.shared.pressStart2P(size: UIDevice.isIpad ? 28 : 18)))
                    .foregroundColor(Color(Constant.whiteColor))
            }
            
            Spacer()
            
            HStack(spacing: UIDevice.isIpad ? 8 : 4) {
                ForEach(0..<lives, id:\.self) { num in
                    Image(Constant.heartImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIDevice.isIpad ? 40 : 24, height: UIDevice.isIpad ? 40 : 24)
                }
            }
        }
    }
}
