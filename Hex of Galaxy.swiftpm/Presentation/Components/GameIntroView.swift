//
//  GameIntroView.swift
//
//
//  Created by Muhammad Rizki Ardyan on 18/04/23.
//

import SwiftUI

struct GameIntroView: View {
    
    @Binding var notShowAgain: Bool
    
    @EnvironmentObject var viewModel: PlayScreenViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text(Constant.matchColorOfThePlanets)
                    .font(Font(CustomFont.shared.pressStart2P(size: 24)))
                    .foregroundColor(Color(Constant.primaryColor))
                    .multilineTextAlignment(.center)
                    .lineSpacing(24)
                    .padding(.bottom, 40)
                
                Text(Constant.gameIntro)
                    .font(.system(size: UIDevice.isIpad ? 24 : 16))
                    .padding(.bottom, 40)
                
                HStack {
                    Toggle(isOn: $notShowAgain) {
                        Text(Constant.dontShowMessageAgain)
                            .font(.system(size: UIDevice.isIpad ? 24 : 16))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .foregroundColor(Color(Constant.primaryColor))
                    .padding(.bottom, 40)
                    Spacer()
                }
                
                CustomButton(title: Constant.introButtonText) {
                    viewModel.startGameFromIntro()
                }
            }
            .frame(maxWidth: UIDevice.isIpad ? 640 : UIScreen.screenWidth - 32)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
    }
}


struct GameIntroView_Previews: PreviewProvider {
    static var previews: some View {
        GameIntroView(notShowAgain: .constant(false))
    }
}
