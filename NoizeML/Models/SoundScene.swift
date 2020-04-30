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
//        Bundle(for: BundleTag.self).url(forResource: "a1", withExtension: "mp3")

        URL(string:"https://backendlessappcontent.com/33170295-1C47-434B-BF7D-D23C7D98F29F/38D93EF3-E73E-4FA6-82E0-26145CBF23F6/files/media/a\(rawValue).mp3")
    }

    private final class BundleTag {}
}
