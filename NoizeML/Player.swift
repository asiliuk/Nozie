// https://github.com/objcio/S01E200-from-mvc-to-swiftui-refactoring-model-apis
import Foundation
import AVFoundation
import Combine
import os.log

class Player: NSObject, AVAudioPlayerDelegate, ObservableObject {
    private var audioPlayer: AVAudioPlayer
    private var timer: Timer?
    
    var time: TimeInterval {
        get { audioPlayer.currentTime }
        set { audioPlayer.currentTime = newValue }
    }
    
    init?(url: URL) {
        os_log("Crteating player for %@", url.lastPathComponent)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            return nil
        }

        if let player = try? AVAudioPlayer(contentsOf: url) {
            audioPlayer = player
        } else {
            return nil
        }
        
        super.init()
        
        audioPlayer.delegate = self
    }
    
    func togglePlay() {
        self.objectWillChange.send()
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            timer?.invalidate()
            timer = nil
        } else {
            audioPlayer.play()
            if let t = timer {
                t.invalidate()
            }
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
                self?.objectWillChange.send()
            }
        }
    }
    
    func setProgress(_ time: TimeInterval) {
        self.objectWillChange.send()
        audioPlayer.currentTime = time
    }

    func audioPlayerDidFinishPlaying(_ pl: AVAudioPlayer, successfully flag: Bool) {
        self.objectWillChange.send()
        timer?.invalidate()
        timer = nil
    }
    
    var duration: TimeInterval {
        return audioPlayer.duration
    }
    
    var isPlaying: Bool {
        return audioPlayer.isPlaying
    }
    
    var isPaused: Bool {
        return !audioPlayer.isPlaying && audioPlayer.currentTime > 0
    }
    
    deinit {
        timer?.invalidate()
    }
}
