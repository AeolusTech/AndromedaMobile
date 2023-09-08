//
//  MessageView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 08/09/2023.
//

import SwiftUI
import AVFoundation

struct MessageView: View {
    var messagingWith: String
    var messageNo: Int
    
    @State private var isPlaying = false
    @State private var currentEmoji = "✉️"
    @State private var currentLyrics = "Press play!"
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var player: AVAudioPlayer?
    
    init(person: String, whichMessage: Int) {
        messagingWith = person
        messageNo = whichMessage
        var chosenAudio: URL?
        
        if (messagingWith == weronikaName) {
            if (messageNo == 1) {
                chosenAudio = audioURLfirstAudioPL
            } else {
                chosenAudio = audioURLfeedbackPL
            }
        } else {
            if (messageNo == 1) {
                chosenAudio = audioURLfirstAudioEN
            } else {
                chosenAudio = audioURLfeedbackEN
            }
        }
        
        if let url = chosenAudio {
            do {
                player = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("Couldn't load the audio file")
            }
        }
        
        do {
            // Initialize the audio player to ignore the DoNotDisturb switch on the side of the iPhone
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }

    var body: some View {
        VStack {
            Spacer()
            
            Text(currentEmoji)
                .font(.system(size: 100))
                .fixedSize()
            
            Spacer()
            
            Text(currentLyrics)
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: togglePlayPause) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Spacer()
            }
        }
        .onReceive(timer) { _ in
            updateTimeBasedContent()
        }
    }

    private func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    private func playFirstAudioPL() {
        if let player = player, player.isPlaying {
            let currentTime = String(format: "%.2f", player.currentTime)
            let currentFloatTime = Float(currentTime) ?? 0.0

            switch currentFloatTime {
            case 0..<1.93:
                currentEmoji = "👋"
                currentLyrics = "hej Wera!"
            case 1.93..<2.87:
                currentEmoji = "🤩"
                currentLyrics = "Wraz z Kubą wpadliśmy"
            case 2.87..<4.7:
                currentLyrics = "na super pomysł."
            case 4.7..<5.3:
                currentEmoji = "😡"
                currentLyrics = "Wkurzało nas to,"
            case 5.3..<6.15:
                currentLyrics = "że nagrywając wiadomość"
            case 6.15..<7.33:
                currentLyrics = "głosową i przerabiając ją"
            case 7.33..<8.04:
                currentLyrics = "na tekst tracimy"
            case 8.04..<9.34:
                currentLyrics = "emocje i kontekst!"
            case 9.34..<10.21:
                currentEmoji = "🤬"
                currentLyrics = "Kurde no!"
            case 10.21..<10.95:
                currentLyrics = "To jest mega"
            case 10.95..<12.22:
                currentLyrics = "wkurwiające!"
            case 12.22..<13.50:
                currentEmoji = "💡"
                currentLyrics = "Ale czaj to!"
            case 13.5..<14.6:
                currentEmoji = "🤔"
                currentLyrics = "Wyobraź sobie, że"
            case 14.6..<16.13:
                currentLyrics = "używasz AI, które"
            case 16.13..<17.45:
                currentLyrics = "automatycznie dodaje"
            case 17.45..<18.5:
                currentLyrics = "emoji i dobiera kolor"
            case 18.5..<19.8:
                currentLyrics = "tła do tekstu."
            case 19.8..<20.81:
                currentEmoji = "🙏"
                currentLyrics = "Daj mi, proszę znać"
            case 20.81..<21.84:
                currentLyrics = "co o tym sądzisz!"
            default:
                break
            }
        }
    }
    
    private func playFeedbackPL() {
        if let player = player, player.isPlaying {
            let currentTime = String(format: "%.2f", player.currentTime)
            let currentFloatTime = Float(currentTime) ?? 0.0

            switch currentFloatTime {
            case 0..<1.93:
                currentEmoji = "👋"
                currentLyrics = "hej Wera!"
            case 1.93..<2.87:
                currentEmoji = "🤩"
                currentLyrics = "Wraz z Kubą wpadliśmy"
            case 2.87..<4.7:
                currentLyrics = "na super pomysł."
            case 4.7..<5.3:
                currentEmoji = "😡"
                currentLyrics = "Wkurzało nas to,"
            case 5.3..<6.15:
                currentLyrics = "że nagrywając wiadomość"
            case 6.15..<7.33:
                currentLyrics = "głosową i przerabiając ją"
            case 7.33..<8.04:
                currentLyrics = "na tekst tracimy"
            case 8.04..<9.34:
                currentLyrics = "emocje i kontekst!"
            case 9.34..<10.21:
                currentEmoji = "🤬"
                currentLyrics = "Kurde no!"
            case 10.21..<10.95:
                currentLyrics = "To jest mega"
            case 10.95..<12.22:
                currentLyrics = "wkurwiające!"
            case 12.22..<13.50:
                currentEmoji = "💡"
                currentLyrics = "Ale czaj to!"
            case 13.5..<14.6:
                currentEmoji = "🤔"
                currentLyrics = "Wyobraź sobie, że"
            case 14.6..<16.13:
                currentLyrics = "używasz AI, które"
            case 16.13..<17.45:
                currentLyrics = "automatycznie dodaje"
            case 17.45..<18.5:
                currentLyrics = "emoji i dobiera kolor"
            case 18.5..<19.8:
                currentLyrics = "tła do tekstu."
            case 19.8..<20.81:
                currentEmoji = "🙏"
                currentLyrics = "Daj mi, proszę znać"
            case 20.81..<21.84:
                currentLyrics = "co o tym sądzisz!"
            default:
                break
            }
        }
    }
    
    private func playFirstAudioEN() {
        if let player = player, player.isPlaying {
            let currentTime = String(format: "%.2f", player.currentTime)
            let currentFloatTime = Float(currentTime) ?? 0.0

            switch currentFloatTime {
            case 0..<1.93:
                currentEmoji = "👋"
                currentLyrics = "hej Wera!"
            case 1.93..<2.87:
                currentEmoji = "🤩"
                currentLyrics = "Wraz z Kubą wpadliśmy"
            case 2.87..<4.7:
                currentLyrics = "na super pomysł."
            case 4.7..<5.3:
                currentEmoji = "😡"
                currentLyrics = "Wkurzało nas to,"
            case 5.3..<6.15:
                currentLyrics = "że nagrywając wiadomość"
            case 6.15..<7.33:
                currentLyrics = "głosową i przerabiając ją"
            case 7.33..<8.04:
                currentLyrics = "na tekst tracimy"
            case 8.04..<9.34:
                currentLyrics = "emocje i kontekst!"
            case 9.34..<10.21:
                currentEmoji = "🤬"
                currentLyrics = "Kurde no!"
            case 10.21..<10.95:
                currentLyrics = "To jest mega"
            case 10.95..<12.22:
                currentLyrics = "wkurwiające!"
            case 12.22..<13.50:
                currentEmoji = "💡"
                currentLyrics = "Ale czaj to!"
            case 13.5..<14.6:
                currentEmoji = "🤔"
                currentLyrics = "Wyobraź sobie, że"
            case 14.6..<16.13:
                currentLyrics = "używasz AI, które"
            case 16.13..<17.45:
                currentLyrics = "automatycznie dodaje"
            case 17.45..<18.5:
                currentLyrics = "emoji i dobiera kolor"
            case 18.5..<19.8:
                currentLyrics = "tła do tekstu."
            case 19.8..<20.81:
                currentEmoji = "🙏"
                currentLyrics = "Daj mi, proszę znać"
            case 20.81..<21.84:
                currentLyrics = "co o tym sądzisz!"
            default:
                break
            }
        }
    }
    
    private func playFeedbackEN() {
        if let player = player, player.isPlaying {
            let currentTime = String(format: "%.2f", player.currentTime)
            let currentFloatTime = Float(currentTime) ?? 0.0

            switch currentFloatTime {
            case 0..<1.93:
                currentEmoji = "👋"
                currentLyrics = "hej Wera!"
            case 1.93..<2.87:
                currentEmoji = "🤩"
                currentLyrics = "Wraz z Kubą wpadliśmy"
            case 2.87..<4.7:
                currentLyrics = "na super pomysł."
            case 4.7..<5.3:
                currentEmoji = "😡"
                currentLyrics = "Wkurzało nas to, że"
            case 5.3..<6.15:
                currentLyrics = "nagrywając wiadomość"
            case 6.15..<7.33:
                currentLyrics = "głosową i przerabiając ją"
            case 7.33..<8.04:
                currentLyrics = "na tekst tracimy"
            case 8.04..<9.34:
                currentLyrics = "emocje i kontekst!"
            case 9.34..<10.21:
                currentEmoji = "🤬"
                currentLyrics = "Kurde no!"
            case 10.21..<10.95:
                currentLyrics = "To jest mega"
            case 10.95..<12.22:
                currentLyrics = "wkurwiające!"
            case 12.22..<13.50:
                currentEmoji = "💡"
                currentLyrics = "Ale czaj to!"
            case 13.5..<14.6:
                currentEmoji = "🤔"
                currentLyrics = "Wyobraź sobie, że"
            case 14.6..<16.13:
                currentLyrics = "używasz AI, które"
            case 16.13..<17.45:
                currentLyrics = "automatycznie dodaje"
            case 17.45..<18.5:
                currentLyrics = "emoji i dobiera kolor"
            case 18.5..<19.8:
                currentLyrics = "tła do tekstu."
            case 19.8..<20.81:
                currentEmoji = "🙏"
                currentLyrics = "Daj mi, proszę znać"
            case 20.81..<21.84:
                currentLyrics = "co o tym sądzisz."
            default:
                break
            }
        }
    }
    
    private func updateTimeBasedContent() {
        if (messagingWith == weronikaName) {
            if (messageNo == 1) {
                playFirstAudioPL()
            } else {
                playFeedbackPL()
            }
        } else {
            if (messageNo == 1) {
                playFirstAudioEN()
            } else {
                playFeedbackEN()
            }
        }
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(person: weronikaName, whichMessage: 1)
    }
}
