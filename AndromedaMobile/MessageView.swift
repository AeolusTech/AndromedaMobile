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
            let currentTime = player.currentTime
            switch currentTime {
            case 0..<10:
                currentEmoji = "🎵"
                currentLyrics = "Lyrics 1"
            case 10..<20:
                currentEmoji = "🔥"
                currentLyrics = "Lyrics 2"
            // Add more cases as needed
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
