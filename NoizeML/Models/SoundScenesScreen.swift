import Foundation

final class SoundScenesScreen {

    final class SceneCard {
        let scene: SoundScene
        let resource: OnDemandResource

        init(scene: SoundScene) {
            self.scene = scene
            self.resource = OnDemandResource(tag: scene.soundFileTag)
        }
    }

    let cards: [SceneCard]

    init() {
        self.cards = SoundScene.allCases.map(SceneCard.init)
    }
}
