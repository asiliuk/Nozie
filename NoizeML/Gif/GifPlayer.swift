import Foundation
import SwiftUI
import Combine

final class GifPlayer: ObservableObject {

    var image: CGImage { frame.image }

    init(gif: Gif) {
        self.gif = gif
        self.frameIndex = gif.frames.startIndex
    }

    func play() {
        startPlaying(frameIndex: frameIndex)
    }

    func pause() {
        playing = nil
    }

    private func startPlaying(frameIndex: Int) {
        self.frameIndex = frameIndex
        let nextIndex = frameIndex + 1
        let index = gif.frames.indices.contains(nextIndex) ? nextIndex : gif.frames.startIndex
        let delay = Int(frame.delay.converted(to: .milliseconds).value)

        playing = Just(index)
            .delay(for: .milliseconds(delay), scheduler: RunLoop.main)
            .sink { [weak self] in self?.startPlaying(frameIndex: $0) }
    }

    private var frame: Gif.Frame { gif.frames[frameIndex] }
    @Published private var frameIndex: Int
    private let gif: Gif
    private var playing: AnyCancellable?
}

extension GifPlayer {
    convenience init?(url: URL) {
        guard let gif = Gif(url: url) else {
            return nil
        }

        self.init(gif: gif)
    }

    convenience init?(data: Data) {
        guard let gif = Gif(data: data) else {
            return nil
        }

        self.init(gif: gif)
    }
}
