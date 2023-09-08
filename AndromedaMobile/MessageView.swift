//
//  MessageView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 08/09/2023.
//

import SwiftUI
import AVFoundation

struct MessageView: View {
    @State private var isPlaying = false
    @State private var currentEmoji = "🎵"
    @State private var currentLyrics = "Let it start"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var player: AVAudioPlayer?
    
    init() {
        if let url = audioURLfirstAudioPL {
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
    
    private func updateTimeBasedContent() {
        if let player = player, player.isPlaying {
            let currentTime = String(format: "%.2f", player.currentTime)
            let currentFloatTime = Float(currentTime) ?? 0.0

            switch currentFloatTime {
            case 0..<1.93:
                currentEmoji = "👋"
                currentLyrics = "hej Wera!"
            case 1.93..<4.7:
                currentEmoji = "🤩"
                currentLyrics = "Wraz z Kubą wpadliśmy na super pomysł."
            case 4.7..<9.34:
                currentEmoji = "😡"
                currentLyrics = "Wkurzało nas to, że nagrywając wiadomość głosową i przerabiając ją  na tekst tracimy emocje i kontekst!"
            case 9.34..<12.22:
                currentEmoji = "🤬"
                currentLyrics = "Kurde, to jest mega wkurwiające!"
            case 12.22..<13.50:
                currentEmoji = "💡"
                currentLyrics = "Ale czaj to!"
            case 13.5..<19.8:
                currentEmoji = "🤔"
                currentLyrics = "Wyobraź sobie, że używasz AI, które automatycznie dodaje emoji i dobiera kolor tła do tekstu."
            case 19.8..<22.74:
                currentEmoji = "🙏"
                currentLyrics = "Daj mi, proszę znać co o tym sądzisz!"
            default:
                break
            }
        }
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
