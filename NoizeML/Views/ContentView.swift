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
