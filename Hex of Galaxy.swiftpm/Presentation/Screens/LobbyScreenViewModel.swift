//
//  LobbyScreenViewModel.swift
//  
//
//  Created by Muhammad Rizki Ardyan on 07/04/23.
// o

import SwiftUI

class LobbyScreenViewModel: ObservableObject {
    @Published var credits: [Credit] = []
    
    init() {
        getCredits()
    }
    
    func getCredits() {
        credits = ResourceManager.instance.getCredits()
    }
}
