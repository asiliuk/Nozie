import Foundation
import SwiftUI

struct SceneCardView: View {

    let scene: SoundScene

    var body: some View {
        ZStack(alignment: .bottom) {
            player
            infoPanel
        }
        .cornerRadius(5)
    }

    private var player: some View {
        scene.coverImage
            .flatMap(Gif.init)
            .map(GifPlayer.init)
            .map(GifPlayerView.init)
    }

    private var infoPanel: some View {
        HStack {
            Text(scene.title)
                .font(Font.title.bold())

            Spacer()

            SoundSceneStateIndicatorView()
        }
        .foregroundColor(.white)
        .padding(.horizontal, 4)
        .background(infoPanelBackground,alignment: .bottom)
        .clipped()
    }

    private var infoPanelBackground: some View {
        UIImage(named: scene.coverImageName)
            .map {
                Image(uiImage: $0)
                    .resizable()
                    .scaledToFill()
            }
            .blur(radius: 8, opaque: true)
    }
}
