//
//  BackgroundView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 19/04/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Color.clear
            .background {
                Image(Constant.backgroundImage)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
            }
    }
}
