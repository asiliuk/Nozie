import Foundation
import Combine

final class OnDemandResource: ObservableObject {

    enum State {
        case unknown
        case paused
        case playing
        case inProgress(Double)
        case needToLoad
    }

    @Published private(set) var state: State = .unknown
    @Published private(set) var error: Error?

    init(tag: String) {
        self.request = NSBundleResourceRequest(tags: [tag])
        self.request.conditionallyBeginAccessingResources { [weak self] loaded in
            DispatchQueue.main.async {
                self?.state = loaded ? .paused : .needToLoad
            }
        }

        self.request.progress
            .publisher(for: \.fractionCompleted, options: .new)
            .map { $0 < 1 ? .inProgress($0) : .paused }
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.state = $0 }
            .store(in: &cancellables)
    }

    func action() {
        switch state {
        case .unknown:
            break
        case .paused:
            break // play
        case .playing:
            break // pause
        case .inProgress:
            self.request.progress.cancel()
        case .needToLoad:
            self.request.beginAccessingResources { [weak self] error in
                DispatchQueue.main.async {
                    self?.error = error
                }
            }
        }
    }

    private let request: NSBundleResourceRequest
    private var cancellables: Set<AnyCancellable> = []
}
