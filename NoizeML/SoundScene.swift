import Foundation
import SwiftUI

enum SoundScene: String, CaseIterable {
    case waterfallInForest = "i1"
    case thunderstormRain = "i2"
    case cafeMusic = "i3"
    case brownNoise = "i4"
    case rainyDay = "i5"
    case medievalTown = "i6"
    case celestialNoise = "i7"
    case metropolisSoundscape = "i8"
    case snowyBlizzard = "i9"
    case forestAmbience = "i10"
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

    var coverImage: URL? {
        bundle.url(forResource: rawValue, withExtension: "gif")
    }

    var soundFild: URL? {
        bundle.url(forResource: rawValue, withExtension: "mp4")
    }

    private var bundle: Bundle { Bundle(for: BundleTag.self) }
    private final class BundleTag {}
}
