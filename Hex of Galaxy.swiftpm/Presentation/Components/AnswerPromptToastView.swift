//
//  AnswerPromptToastView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 16/04/23.
//

import SwiftUI

struct AnswerPromptToastView: View {
    let state: State
    
    enum State {
        case correct
        case wrong
        case hidden
    }
    
    var body: some View {
        HStack {
            Text(state == .correct ? Constant.correctPromptToast : Constant.wrongPromptToast)
                .font(.system(size: UIDevice.isIpad ? 40 : 24, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(Constant.whiteColor))
                .padding(.horizontal, 32)
                .padding(.vertical, 40)
                .frame(minWidth: UIDevice.isIpad ? 540 : UIScreen.screenWidth - 80)
                .background {
                    state == .correct ?
                    Color.green :
                    Color.red
                }
                .cornerRadius(24)
        }
    }
}

struct AnswerPromptToastView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerPromptToastView(state: .correct)
    }
}
