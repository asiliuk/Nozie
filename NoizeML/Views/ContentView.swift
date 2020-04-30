//
//  ContentView.swift
//  NoizeML
//
//  Created by Anton Siliuk on 4/23/20.
//  Copyright © 2020 Anton Siliuk. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let screen = SoundScenesScreen()

    var body: some View {
        NavigationView {
            List(screen.cards, id: \.scene.rawValue) { card in
                Spacer()

                SceneCardView(card: card)
                    .padding(.vertical)
                    .frame(maxWidth: 600, alignment: .center)

                Spacer()
            }
            .navigationBarTitle("Sound scenes")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
