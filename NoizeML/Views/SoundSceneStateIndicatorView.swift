import Foundation
import SwiftUI

struct SoundSceneStateIndicatorView: View {

    enum State {
        case download
        case inProgress(CGFloat)
        case play
        case pause
    }

    var state: State = .download
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) { () -> AnyView in
            switch self.state {
            case .download:
                return AnyView(Image(systemName: "square.and.arrow.down"))
            case let .inProgress(progress):
                return AnyView(DownloadProgressView(progress: progress).padding(6))
            case .play:
                return AnyView(Image(systemName: "play.fill").offset(x: 2))
            case .pause:
                return AnyView(Image(systemName: "pause.fill").offset(x: 2))
            }
        }
        .frame(width: 44, height: 44)
    }
}

private struct DownloadProgressView: View {

    let progress: CGFloat
    init(progress: CGFloat) {
        self.progress = max(min(progress, 1), 0)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.gray)
                .opacity(0.6)

            Image(systemName: "stop.fill")
                .resizable()
                .padding(8)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
        }
        .padding(lineWidth / 2)
    }

    private let lineWidth: CGFloat = 2

}

#if DEBUG
struct SoundSceneStateIndicator_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SoundSceneStateIndicatorView()
            SoundSceneStateIndicatorView(state: .inProgress(0.8))
            SoundSceneStateIndicatorView(state: .play)
            SoundSceneStateIndicatorView(state: .pause)
        }
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
#endif
