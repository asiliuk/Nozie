import Foundation
import Combine

final class OnDemandResource: ObservableObject {

    enum State {
        case unknown
        case downloaded
        case inProgress(Double)
        case needToLoad
    }

    @Published private(set) var state: State = .unknown
    @Published private(set) var error: Error?

    init(tag: String) {
        self.request = NSBundleResourceRequest(tags: [tag])
        self.request.conditionallyBeginAccessingResources { [weak self] loaded in
            DispatchQueue.main.async {
                self?.state = loaded ? .downloaded : .needToLoad
            }
        }

        self.request.progress
            .publisher(for: \.fractionCompleted, options: .new)
            .map { $0 < 1 ? .inProgress($0) : .downloaded }
            .receive(on: RunLoop.main)
            .sink { [weak self] in self?.state = $0 }
            .store(in: &cancellables)
    }

    func cancel() {
        self.request.progress.cancel()
    }

    func download() {
        self.request.beginAccessingResources { [weak self] error in
            DispatchQueue.main.async {
                self?.error = error
            }
        }
    }

    private let request: NSBundleResourceRequest
    private var cancellables: Set<AnyCancellable> = []
}
