import Foundation
import Combine

final class SoundScenesScreen {

    final class SceneCard {
        let scene: SoundScene
        let state: SoundSceneState

        init(scene: SoundScene) {
            self.scene = scene
            self.state = SoundSceneState(scene: scene)
        }
    }

    let cards: [SceneCard]

    init() {
        self.cards = SoundScene.allCases.map(SceneCard.init)
    }
}

final class SoundSceneState: ObservableObject {

    enum State {
        case unknown
        case download
        case loading(Double)
        case play
        case pause
    }

    var state: State {
        switch resource.state {
        case .unknown:
            return .unknown
        case .needToLoad:
            return .download
        case let .inProgress(progress):
            return .loading(progress)
        case .downloaded:
            return player?.isPlaying == true ? .pause : .play
        }
    }

    init(scene: SoundScene) {
        self.scene = scene
        self.resource = OnDemandResource(tag: scene.soundFileTag)
        self.resource.objectWillChange
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellables)
    }

    func action() {
        switch state {
        case .unknown:
            break
        case .download:
            resource.download()
        case .loading:
            resource.cancel()
        case .play, .pause:
            if player == nil {
                player = scene.soundFile.flatMap { Player(url: $0) }
                player?.objectWillChange
                    .sink(receiveValue: objectWillChange.send)
                    .store(in: &cancellables)
            }
            player?.togglePlay()
        }
    }

    private var player: Player?
    private let scene: SoundScene
    private let resource: OnDemandResource
    private var cancellables: Set<AnyCancellable> = []
}
