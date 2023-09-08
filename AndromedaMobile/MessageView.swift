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
    @State private var backgroundColor = Color.white

    
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
                .foregroundColor(.black)
                .background(
                    Text(currentLyrics)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 2, y: 2)
                )
                .overlay(
                    Text(currentLyrics)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: -2, y: -2)
                )

            
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
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        .onReceive(timer) { _ in
            if let hexValue = emojiToColorHex[currentEmoji] {
                backgroundColor = Color(hex: hexValue)
            }
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
            case 0.00..<0.68:
                currentEmoji = ""
                currentLyrics = ""
            case 0.68..<1.93:
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
                currentEmoji = "🤯"
                currentLyrics = "Ale czaj to!"
            case 13.5..<14.6:
                currentEmoji = "👀"
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
            case 0.00..<0.48:
                currentEmoji = ""
                currentLyrics = ""
            case 0.48..<0.93:
                currentEmoji = "😌"
                currentLyrics = "No i ogólnie"
            case 0.93..<1.60:
                currentLyrics = "kiedy odsłuchasz"
            case 1.60..<2.6:
                currentLyrics = "wiadomość, to Emoji"
            case 2.6..<3.68:
                currentLyrics = "zostają w tekście."
            case 3.68..<4.89:
                currentLyrics = "Taki jest pomysł."
            case 5.31..<6.43:
                currentEmoji = "😘"
                currentLyrics = "Byłoby nam mega"
            case 6.43..<7.36:
                currentLyrics = "miło, gdybyś opowiedział"
            case 7.36..<8.54:
                currentLyrics = "co sądzisz o tym"
            case 8.54..<9.45:
                currentLyrics = "pomyśle w GoogleForms."
            case 9.45..<10.39:
                currentEmoji = "⬇️"
                currentLyrics = "Link poniżej"
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
            case 0.00..<0.50:
                currentEmoji = ""
                currentLyrics = ""
            case 0.50..<1.61:
                currentEmoji = "👋"
                currentLyrics = "hej Babe!"
            case 1.61..<2.43:
                currentEmoji = "🤩"
                currentLyrics = "Kuba and I came up"
            case 2.43..<3.68:
                currentLyrics = "with an awesome idea."
            case 4.50..<5.48:
                currentEmoji = "😡"
                currentLyrics = "It annoyed us that"
            case 5.48..<6.5:
                currentLyrics = "when recording a"
            case 6.5..<7.40:
                currentLyrics = "voice message and"
            case 7.40..<8.39:
                currentLyrics = "converting it to text"
            case 8.39..<9.37:
                currentLyrics = "we lose emotions"
            case 9.37..<10.29:
                currentLyrics = "and context!"
            case 10.59..<11.44:
                currentEmoji = "🤬"
                currentLyrics = "Damn..."
            case 11.44..<12:
                currentLyrics = "it's fucking"
            case 12..<12.70:
                currentLyrics = "annoying!"
            case 13.04..<14.15:
                currentEmoji = "🤯"
                currentLyrics = "But check this out!"
            case 14.64..<15.31:
                currentEmoji = "👀"
                currentLyrics = "Imagine, you're"
            case 15.31..<16.34:
                currentLyrics = "using AI that"
            case 16.34..<17.36:
                currentLyrics = "automatically adds"
            case 17.36..<18.35:
                currentLyrics = "Emojis to text"
            case 18.35..<19:
                currentLyrics = "and picks the"
            case 19..<19.8:
                currentLyrics = "background color"
            case 20.57..<21.14:
                currentEmoji = "🙏"
                currentLyrics = "Let me know"
            case 21.14..<21.70:
                currentLyrics = "what you think!"
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
            case 0.00..<0.48:
                currentEmoji = ""
                currentLyrics = ""
            case 0.48..<1.22:
                currentEmoji = "😌"
                currentLyrics = "When you’ve listened"
            case 1.22..<1.81:
                currentLyrics = "to the message,"
            case 1.81..<3.11:
                currentLyrics = "the emojis are"
            case 3.11..<4.13:
                currentLyrics = "embedded in text."
            case 4.67..<5.55:
                currentLyrics = "Dear user!"
            case 5.78..<6.25:
                currentEmoji = "😘"
                currentLyrics = "We'd be really"
            case 6.25..<7.36:
                currentLyrics = "happy if you could"
            case 7.36..<7.99:
                currentLyrics = "tell us what"
            case 7.99..<8.27:
                currentLyrics = "you think"
            case 8.27..<9.14:
                currentLyrics = "about the idea."
            case 9.14..<10.39:
                currentEmoji = "⬇️"
                currentLyrics = "Link below"
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
        MessageView(person: weronikaName, whichMessage: 2)
    }
}
