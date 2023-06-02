//
//  GameOverModalView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 16/04/23.
//

import SwiftUI

struct GameOverModalView: View {
    let score: Int
    let bestPlanet: BestPlanet?
    
    @Binding var isPlayScreenActive: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Text("\(Constant.yourMissionOver) \(String(score))")
                    .font(Font(CustomFont.shared.pressStart2P(size: UIDevice.isIpad ? 16 : 14)))
                    .lineSpacing(12.0)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(Color(Constant.whiteColor))
                    .padding(.bottom, 16)
                
                if let bestPlanet {
                    VStack(spacing: 16) {
                        HStack(spacing: UIDevice.isIpad ? 24 : 16) {
                            Image(PlanetName(rawValue: bestPlanet.planet.name)?.rawValue ?? "")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIDevice.isIpad ? 200 : 100)
                            
                            VStack(alignment: .leading, spacing: UIDevice.isIpad ? 16 : 8) {
                                Text(Constant.planetYouConquered)
                                    .font(Font(CustomFont.shared.pressStart2P(size: 12)))
                                    .lineSpacing(16)
                                    .foregroundColor(Color.gray)
                                
                                Text(bestPlanet.planet.name)
                                    .font(Font(CustomFont.shared.pressStart2P(size: UIDevice.isIpad ? 40 : 24)))
                                    .foregroundColor(Color(Constant.primaryColor))
                                
                                Text("#\(bestPlanet.planet.hex[0])")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                                    .background {
                                        Color(hue: bestPlanet.planet.hsbInDouble[0].hue,
                                              saturation: bestPlanet.planet.hsbInDouble[0].saturation,
                                              brightness: bestPlanet.planet.hsbInDouble[0].brightness)
                                        .opacity(0.4)
                                    }
                                    .cornerRadius(8)
                            }
                            Spacer()
                        }
                        
                        Text(bestPlanet.planet.trivia)
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Divider()
                    .padding(.top, 32)
                    .padding(.bottom, 8)
                
                Button {
                    isPlayScreenActive = false
                } label: {
                    Text(Constant.backToLobbyString)
                        .fontWeight(.medium)
                        .foregroundColor(Color.red)
                }
            }
            .foregroundColor(Color(Constant.whiteColor))
            .padding(.horizontal, 18)
            .padding(.top, 40)
            .padding(.bottom, 24)
            .frame(maxWidth: UIDevice.isIpad ? 620 : UIScreen.screenWidth - 40)
            .background(.ultraThinMaterial)
            .cornerRadius(16)
        }
    }
}
