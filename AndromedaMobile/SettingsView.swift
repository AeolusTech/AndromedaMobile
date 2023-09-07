//
//  SwiftUIView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 07/09/2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var darkMode: Bool
    @Binding var emojiEnable: Bool
    @Binding var backgroundColorEnable: Bool
    
    @ObservedObject private var audioRecorder = AudioRecorder()
    
    let audioURLfirstAudioEN = getAudioURL(filename: "firstAudioEN", type: "m4a")
    let audioURLfeedbackEN = getAudioURL(filename: "feedbackEN", type: "m4a")
    let audioURLfirstAudioPL = getAudioURL(filename: "firstAudioPL", type: "m4a")
    let audioURLfeedbackPL = getAudioURL(filename: "feedbackPL", type: "m4a")
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Dark Mode", isOn: $darkMode)
                    .onChange(of: darkMode) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "DarkMode")
                    }
                Toggle("Emoji Enable", isOn: $emojiEnable)
                    .onChange(of: emojiEnable) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "EmojiEnable")
                    }
                Toggle("Background Color", isOn: $backgroundColorEnable)
                    .onChange(of: backgroundColorEnable) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "BackgroundColorEnable")
                    }

                Button(action: {
                    print("First audio PL")
                    if let safeURL = audioURLfirstAudioPL {
                        audioRecorder.playAudio(path: safeURL)
                    }
                }) {
                    Text("First audio PL")
                }
                Button(action: {
                    print("Feedback PL")
                    if let safeURL = audioURLfeedbackPL {
                        audioRecorder.playAudio(path: safeURL)
                    }
                }) {
                    Text("Feedback PL")
                }
                Button(action: {
                    print("First audio EN")
                    if let safeURL = audioURLfirstAudioEN {
                        audioRecorder.playAudio(path: safeURL)
                    }
                }) {
                    Text("First audio EN")
                }
                Button(action: {
                    print("Feedback EN")
                    if let safeURL = audioURLfeedbackEN {
                        audioRecorder.playAudio(path: safeURL)
                    }
                }) {
                    Text("Feedback EN")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}



struct SettingsView_Previews: PreviewProvider {
    @State static var mockDarkMode = false
    @State static var mockEmojiEnable = false
    @State static var mockBackgroundColorEnable = false

    
    static var previews: some View {
        SettingsView(
            darkMode: $mockDarkMode,
            emojiEnable: $mockEmojiEnable,
            backgroundColorEnable: $mockBackgroundColorEnable
        )
    }
}
