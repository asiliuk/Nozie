import Foundation
import SwiftUI

enum SoundScene: Int, CaseIterable {
    case waterfallInForest = 1
    case thunderstormRain
    case cafeMusic
    case brownNoise
    case rainyDay
    case medievalTown
    case celestialNoise
    case metropolisSoundscape
    case snowyBlizzard
    case forestAmbience
}

extension SoundScene {
    var title: LocalizedStringKey {
        switch self {
        case .waterfallInForest:
            return "Waterfall in a forest"
        case .thunderstormRain:
            return "Thunderstorm & Rain"
        case .cafeMusic:
            return "Cafe Music"
        case .brownNoise:
            return "Brown Noise"
        case .rainyDay:
            return "Rainy Day"
        case .medievalTown:
            return "Medieval Town"
        case.celestialNoise:
            return "Celestial Noise"
        case .metropolisSoundscape:
            return "Metropolis Soundscape"
        case .snowyBlizzard:
            return "Snowy Blizzard"
        case .forestAmbience:
            return "Forest Ambience"
        }
    }
}

extension SoundScene {

    var coverImageName: String {
        "i\(rawValue).gif"
    }

    var coverImage: URL? {
        Bundle(for: BundleTag.self).url(forResource: "i\(rawValue)", withExtension: "gif")
    }

    var soundFild: URL? {
        bundle.url(forResource: rawValue, withExtension: "mp4")
    }

    private var bundle: Bundle { Bundle(for: BundleTag.self) }
    private final class BundleTag {}
}
