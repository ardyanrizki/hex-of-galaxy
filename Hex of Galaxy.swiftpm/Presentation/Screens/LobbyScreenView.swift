//
//  LobbyScreenView.swift
//  Hex of Galaxy
//
//  Created by Muhammad Rizki Ardyan on 07/04/23.
//

import SwiftUI

struct LobbyScreenView: View {
    @StateObject var viewModel = LobbyScreenViewModel()
    @Binding var isPlayScreenActive: Bool
    @State private var showingCredits = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingCredits.toggle()
                    } label: {
                        Text(Constant.credits)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(Constant.primaryColor))
                    }
                    .sheet(isPresented: $showingCredits) {
                        if #available(iOS 16.0, *) {
                            CreditsView(credits: viewModel.credits)
                                .presentationDetents([.large])
                        } else {
                            CreditsView(credits: viewModel.credits)
                        }
                    }
                }
                
                Spacer()
                
                Image(Constant.logoImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIDevice.isIpad ? 560 : UIScreen.screenWidth - 48)
                
                Text(Constant.matchColorOfThePlanets)
                    .font(Font(CustomFont.shared.pressStart2P(size: 18)))
                    .foregroundColor(Color(Constant.whiteColor).opacity(0.8))
                
                Spacer()
                
                VStack(spacing: 40) {
                    LobbyInteractableCircleView()
                    
                    LobbyGameInstructionView()
                }
                
                Spacer()
                
                CustomButton(title: Constant.playString) {
                    isPlayScreenActive = true
                }
                .frame(maxWidth: UIDevice.isIpad ? 400 : UIScreen.screenWidth - 32)
            }
            .padding()
        }
    }
}

struct LobbyScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyScreenView(isPlayScreenActive: .constant(false))
    }
}
