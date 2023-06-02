//
//  CreditsView.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 16/04/23.
//

import SwiftUI

struct CreditsView: View {
    let credits: [Credit]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(Constant.credits)
                .font(Font(CustomFont.shared.pressStart2P(size: 24)))
                .padding(.top, 24)
                .padding(.bottom, 18)
                .foregroundColor(Color(Constant.primaryColor))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    ForEach(credits) { credit in
                        CreditListView(credit: credit)
                    }
                }
            }
        }
        .foregroundColor(Color(Constant.whiteColor))
        .padding(.vertical, UIDevice.isIpad ? 40 : 12)
        .padding(.horizontal, UIDevice.isIpad ? 80 : 12)
        .frame(maxWidth: UIDevice.isIpad ? UIScreen.screenWidth - 100 : UIScreen.screenWidth - 32, alignment: .leading)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView(credits: [])
    }
}

struct CreditListView: View {
    let credit: Credit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(credit.category)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)
            
            ForEach(credit.list) { credit in
                VStack(alignment: .leading, spacing: 4) {
                    Text(credit.title)
                        .font(.headline)
                        .fontWeight(.bold)

                    Link(destination: URL(string: credit.url)!) {
                        Text(credit.linkLabel)
                            .font(.subheadline)
                            .foregroundColor(Color.blue)
                    }
                }
                .multilineTextAlignment(.leading)
            }
        }
    }
}
