//
//  CustomButton.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI

struct CustomButton: View {
    @State var isPressing: Bool = false
    let offset: CGFloat = 8
    let title: String
    let actionAfterPressed: () -> Void
    
    var body: some View {
        Button {} label: {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color(Constant.primaryShadeColor))
                    .offset(y: offset)
                
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(Color(Constant.primaryColor))
                    .offset(y: isPressing ? offset : 0)
                
                Text(title)
                    .font(Font(CustomFont.shared.pressStart2P(size: UIDevice.isIpad ? 24 : 18)))
                    .foregroundColor(Color(Constant.blackColor))
                    .offset(y: isPressing ? offset : 0)
                
            }
            .onLongPressGesture(pressing: { pressing in
                isPressing = pressing
                if !isPressing {
                    actionAfterPressed()
                }
            }, perform: {})
            .frame(height: UIDevice.isIpad ? 80 : 52)
            .compositingGroup()
            .shadow(radius: 6, y: 4)
        }
    }
}
