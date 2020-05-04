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
                return AnyView(Image(systemName: "pause.fill"))
            }
        }
        .frame(minWidth: 44, minHeight: 44)
    }
}

private struct DownloadProgressView: View {

    let progress: CGFloat
    init(progress: CGFloat) {
        self.undefinedProgress = progress < minProgress
        self.progress = max(min(progress, 1), minProgress)
    }

    var body: some View {
        Image(systemName: "stop.fill")
            .overlay(GeometryReader { proxy in
                self.progressCircle.padding(-proxy.size.width / 1.5)
            })
    }

    private var progressCircle: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.gray)
                .opacity(0.6)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(Angle(degrees: isLoadingPreparation ? 270 : -90))
                .onAppear {
                    guard self.undefinedProgress else { return }
                    withAnimation(self.loadingPreparationAnimation) { self.isLoadingPreparation.toggle() }
                }
        }
        .padding(lineWidth / 2)
    }

    @Environment(\.sizeCategory) private var sizeCategory
    private var lineWidth: CGFloat { sizeCategory.progressLineWidth }

    private let minProgress: CGFloat = 0.1
    @State private var isLoadingPreparation = false
    private let loadingPreparationAnimation = Animation
        .linear(duration: 1)
        .repeatForever(autoreverses: false)

    private let undefinedProgress: Bool
}

private extension ContentSizeCategory {

    var progressLineWidth: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1
        case .large:
            return 2
        case .extraLarge, .extraExtraLarge, .extraExtraExtraLarge:
            return 3
        case .accessibilityMedium, .accessibilityLarge:
            return 6
        case .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            return 8
        @unknown default:
            return 2
        }
    }
}

#if DEBUG
struct SoundSceneStateIndicator_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            SoundSceneStateIndicatorView()
            SoundSceneStateIndicatorView(state: .inProgress(0))
            SoundSceneStateIndicatorView(state: .inProgress(0.8))
            SoundSceneStateIndicatorView(state: .play)
            SoundSceneStateIndicatorView(state: .pause)
        }
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
#endif
