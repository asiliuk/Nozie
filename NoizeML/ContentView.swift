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
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GifPlayerView: View {

    @ObservedObject var player: GifPlayer

    var body: some View {
        Image(decorative: player.image, scale: UIScreen.main.scale)
            .resizable()
            .aspectRatio(480 / 270, contentMode: .fit)
            .background(Color.gray)
            .cornerRadius(5)
            .onAppear(perform: player.play)
            .onDisappear(perform: player.pause)
    }
}
