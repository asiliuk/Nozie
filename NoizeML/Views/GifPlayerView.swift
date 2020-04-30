import Foundation
import SwiftUI

struct GifPlayerView: View {

    @ObservedObject var player: GifPlayer

    var body: some View {
        Image(decorative: player.image, scale: UIScreen.main.scale)
            .resizable()
            .aspectRatio(480 / 270, contentMode: .fit)
            .background(Color.gray)
            .onAppear(perform: player.play)
            .onDisappear(perform: player.pause)
    }
}
