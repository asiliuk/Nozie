import SwiftUI

struct SoundSceneStateView: View {

    @ObservedObject var state: SoundSceneState

    var body: some View {
        SoundSceneStateIndicatorView(
            state: state.state.viewState,
            action: state.action
        )
    }
}

private extension SoundSceneState.State {
    var viewState: SoundSceneStateIndicatorView.State {
        switch self {
        case .unknown, .download:
            return .download
        case let .loading(progress):
            return .inProgress(CGFloat(progress))
        case .play:
            return .play
        case .pause:
            return .pause
        }
    }
}
