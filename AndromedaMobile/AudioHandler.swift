//
//  AudioHandler.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 07/09/2023.
//

import Foundation
import AVFoundation


func getAudioURL(filename: String, type: String) -> URL? {
    return Bundle.main.url(forResource: filename, withExtension: type)
}

let audioURLfirstAudioEN = getAudioURL(filename: "firstAudioEN", type: "m4a")
let audioURLfeedbackEN = getAudioURL(filename: "feedbackEN", type: "m4a")
let audioURLfirstAudioPL = getAudioURL(filename: "firstAudioPL", type: "m4a")
let audioURLfeedbackPL = getAudioURL(filename: "feedbackPL", type: "m4a")


class AudioRecorder: ObservableObject {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(Date().timeIntervalSince1970).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
        } catch {
            print("Could not start recording")
        }
    }

    
    func stopRecording() -> URL {
        audioRecorder.stop()
        return audioRecorder.url
    }

    
    func playAudio(path: URL) {
        do {
            // Configure the audio session for playback through the main speaker
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            
            self.audioPlayer = try AVAudioPlayer(contentsOf: path)
            self.audioPlayer?.play()
        } catch {
            print("Audio playback failed")
        }
    }

}
