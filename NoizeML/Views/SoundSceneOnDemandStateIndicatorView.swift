import SwiftUI

struct OnDemandStateView: View {

    @ObservedObject var resource: OnDemandResource

    var body: some View {
        SoundSceneStateIndicatorView(
            state: resource.state.viewState,
            action: resource.action
        )
    }
}

private extension OnDemandResource.State {
    var viewState: SoundSceneStateIndicatorView.State {
        switch self {
        case .unknown, .needToLoad:
            return .download
        case let .inProgress(progress):
            return .inProgress(CGFloat(progress))
        case .paused:
            return .play
        case .playing:
            return .pause
        }
    }
}
