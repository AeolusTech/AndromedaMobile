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
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Toggle("Dark Mode", isOn: $darkMode)
                        .onChange(of: darkMode) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "DarkMode")
                        }
                    Toggle("Emoji Enable", isOn: $emojiEnable)
                        .onChange(of: emojiEnable) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "EmojiEnable")
                        }
                        .disabled(true)
                    Toggle("Background Color", isOn: $backgroundColorEnable)
                        .onChange(of: backgroundColorEnable) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "BackgroundColorEnable")
                        }
                        .disabled(true)
                }
                .navigationBarTitle("Settings")
                Text("Kamil Kuczaj & Kuba Kułakowski 2023")
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
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
