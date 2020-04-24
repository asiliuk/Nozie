import Foundation
import CoreGraphics
import ImageIO

struct Gif {
    struct Frame {
        let image: CGImage
        let delay: TimeInterval
    }

    let frames: [Frame]

    init(source: CGImageSource) {
        let count = CGImageSourceGetCount(source)
        self.frames = (0..<count).compactMap { Frame(source: source, index: $0) }
    }
}

extension Gif {
    init?(url: URL) {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return nil
        }

        self.init(source: source)
    }

    init?(data: Data) {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }

        self.init(source: source)
    }
}

extension Gif.Frame {
    init?(source: CGImageSource, index: Int) {
        guard
            let image = CGImageSourceCreateImageAtIndex(source, index, nil),
            let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        else {
            return nil
        }

        self.image = image
        self.delay = properties.gifDelay
    }
}

private extension CFDictionary {
    subscript<Value>(key: CFString) -> Value? {
        let key = Unmanaged.passUnretained(key).toOpaque()
        var result: UnsafeRawPointer?
        let read = { CFDictionaryGetValueIfPresent(self, key, $0) }

        guard withUnsafeMutablePointer(to: &result, read), let value = result else { return nil }

        return unsafeBitCast(value, to: Value.self)
    }

    var gifDelay: Double {
        let gifDict: CFDictionary? = self[kCGImagePropertyGIFDictionary]
        let unclampedDelay: NSNumber? = gifDict?[kCGImagePropertyGIFUnclampedDelayTime]
        let delay: NSNumber? = gifDict?[kCGImagePropertyGIFDelayTime]
        return delay?.doubleValue ?? unclampedDelay?.doubleValue ?? 0.1
    }
}
