//
//  ContentView.swift
//  NoizeML
//
//  Created by Anton Siliuk on 4/23/20.
//  Copyright © 2020 Anton Siliuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(SoundScene.allCases, id: \.rawValue) { scene in
                SceneCardView(scene: scene).padding(.vertical)
            }
            .navigationBarTitle("Sound scenes")
        }
    }
}

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
