//
//  ContentView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 05/09/2023.
//

import AVFoundation
import SwiftUI


struct Message: Identifiable, Codable {
    var id = UUID()
    var audioURL: URL
    var transcript: String
    var timestamp: String
}


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
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
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
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        } catch {
            print("Couldn't load audio \(error)")
        }
    }

}


struct ContentView: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = []
    @State private var showSettings = false
    @State private var darkMode = UserDefaults.standard.bool(forKey: "DarkMode")

    @State private var audioURL: URL? = nil
    @State private var isRecording = false
    @State private var showControls = false
    @ObservedObject private var audioRecorder = AudioRecorder()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter
    }
    
    func toggleRecording() {
        isRecording.toggle()
        
        if isRecording {
            audioRecorder.startRecording()
        } else {
            audioURL = audioRecorder.stopRecording()
            showControls = true  // another boolean to decide whether to show Play, Trash, Send buttons
        }
    }

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(messages, id: \.id) { msg in
                        HStack {
                            // Existing code to display message...
                            Button(action: {
                                self.audioRecorder.playAudio(path: msg.audioURL)
                            }) {
                                Image(systemName: "play.fill")
                            }
                            Button(action: {
                                // Code to delete message
                            }) {
                                Image(systemName: "trash.fill")
                            }
                        }
                    }
                }
                
                if showControls {
                    HStack {
                        Button(action: {
                            if let safeURL = audioURL {
                                audioRecorder.playAudio(path: safeURL)
                            }
                        }) {
                            Image(systemName: "play.fill")
                        }
                        Button(action: {
                            audioURL = nil
                            showControls = false
                        }) {
                            Image(systemName: "trash.fill")
                        }
                        Button(action: {
                            // Code to "send" your audio message
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                        }
                    }
                    .padding()
                } else {
                    Button(action: toggleRecording) {
                        Image(systemName: "mic.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
                            .foregroundColor(isRecording ? Color.red : Color.blue)
                    }
                    .padding()
                }
            }
            .navigationBarItems(trailing:
                Button(action: { showSettings.toggle() }) {
                    Image(systemName: "line.horizontal.3")
                }
                .sheet(isPresented: $showSettings) {
                    SettingsView(darkMode: $darkMode)
                }
            )
            .preferredColorScheme(darkMode ? .dark : .light)
            .onAppear {
                if let savedMessagesData = UserDefaults.standard.value(forKey: "Messages") as? Data,
                   let savedMessages = try? JSONDecoder().decode([Message].self, from: savedMessagesData) {
                    self.messages = savedMessages
                }
            }
        }
    }
}

struct SettingsView: View {
    @Binding var darkMode: Bool
    @State private var dummyToggle1 = false
    @State private var dummyToggle2 = false
    @State private var dummyToggle3 = false
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Dark Mode", isOn: $darkMode)
                    .onChange(of: darkMode) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "DarkMode")
                    }
                
                Toggle("Dummy Toggle 1", isOn: $dummyToggle1)
                Toggle("Dummy Toggle 2", isOn: $dummyToggle2)
                Toggle("Dummy Toggle 3", isOn: $dummyToggle3)
            }
            .navigationBarTitle("Settings")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
