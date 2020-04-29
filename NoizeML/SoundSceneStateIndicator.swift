import Foundation
import SwiftUI

struct SoundSceneStateIndicator: View {

    enum State {
        case download
        case inProgress(CGFloat)
        case play
    }

    var state: State = .download
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) { () -> AnyView in
            switch self.state {
            case .download:
                return AnyView(Image(systemName: "square.and.arrow.down"))
            case let .inProgress(progress):
                return AnyView(DownloadProgress(progress: progress).padding(6))
            case .play:
                return AnyView(Image(systemName: "play.fill").offset(x: 2))
            }
        }
        .foregroundColor(.blue)
        .frame(width: 44, height: 44)
        .background(BluredCircle())
    }
}

private struct BluredCircle: View {

    var body: some View {
        Circle()
            .foregroundColor(.white)
            .opacity(0.7)
            .clipShape(Circle())
    }
}

private struct DownloadProgress: View {

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

    private let lineWidth: CGFloat = 4

}

#if DEBUG
struct SoundSceneStateIndicator_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SoundSceneStateIndicator()
            SoundSceneStateIndicator(state: .inProgress(0.8))
            SoundSceneStateIndicator(state: .play)
        }
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
#endif
