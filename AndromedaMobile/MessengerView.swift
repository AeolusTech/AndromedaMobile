//
//  MessengerView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 07/09/2023.
//

import SwiftUI

struct MessengerView: View {
    @State private var showSettings = false

    @State private var darkMode = UserDefaults.standard.bool(forKey: "DarkMode")
    @State private var emojiEnable = UserDefaults.standard.bool(forKey: "EmojiEnable")
    @State private var backgroundColorEnable = UserDefaults.standard.bool(forKey: "BackgroundColorEnable")

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Do this for each entry
                    NavigationLink(destination: ContactView(contactName: weronikaName)) {
                        HStack {
                            Image("sasha")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.leading, 20)
                            
                            Text(weronikaName)
                                .font(.title2)
                                .padding(.leading, 15)
                                .padding()
                            Spacer()
                        }
                        .frame(height: 80)
                        .padding(.bottom, 10)
                    }

                    NavigationLink(destination: ContactView(contactName: babeName)) {
                        HStack {
                            Image("mia")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .padding(.leading, 20)

                            Text(babeName)
                                .font(.title2)
                                .padding(.leading, 15)
                                .padding()
                            Spacer()
                        }
                        .frame(height: 80)
                        .padding(.bottom, 10)
                    }
                }
            }
            .navigationBarTitle("🚀 Andromeda 💫", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { showSettings.toggle() }) {
                    Image(systemName: "gearshape.fill")
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(
                        darkMode: $darkMode,
                        emojiEnable: $emojiEnable,
                        backgroundColorEnable: $backgroundColorEnable
                    )
                }
            )
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}


struct MessengerView_Previews: PreviewProvider {
    static var previews: some View {
        MessengerView()
    }
}
