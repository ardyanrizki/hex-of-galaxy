import SwiftUI

struct ContentView: View {
    @State var isPlayScreenActive: Bool = false
    
    var body: some View {
        Group {
            if isPlayScreenActive {
                PlayScreenView(isPlayScreenActive: $isPlayScreenActive)
            } else {
                LobbyScreenView(isPlayScreenActive: $isPlayScreenActive)
            }
        }
        .preferredColorScheme(.dark)
    }
}
