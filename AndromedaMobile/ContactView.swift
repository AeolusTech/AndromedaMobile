//
//  ContentView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 05/09/2023.
//

import SwiftUI
import Foundation
import AVFoundation


struct Message: Identifiable, Codable {
    var id = UUID()
    var audioURL: URL
    var transcript: String
    var timestamp: String
}

struct ContactView: View {
    var contactName: String
    @State private var messages: [Message] = []
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State private var audioURL: URL? = nil
    @State private var isRecording = false
    @State private var showControls = false
    @ObservedObject private var audioRecorder = AudioRecorder()
    
    @State private var firstMessageListened = false
    @State private var secondMessageListened = false
    
    var profileImage: String {
        if contactName == weronikaName {
            return "sasha"
        } else if contactName == babeName {
            return "mia"
        } else {
            return "no-profile-photo" // Fallback
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter
    }
    
    func toggleRecording() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            if audioSession.isOtherAudioPlaying {
                try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            }
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
        } catch {
            print("Couldn't set up audio session")
            self.showingAlert = true
            self.alertMessage = "Audio playback failed"
        }

        
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
                HStack {
                    Spacer()
                    Image(profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    Text(contactName)
                        .font(.largeTitle)
                    Spacer()
                }
                .padding(.horizontal)
                Divider()
                List {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Button(action: {
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
                                            let vc = UIHostingController(rootView: MessageView())
                                            keyWindow.rootViewController?.present(vc, animated: true, completion: nil)
                                        }
                                    firstMessageListened = true
                                }) {
                                    Image(systemName: "play.fill")
                                }
                                Spacer()
                                Image("audio-spectrum-1")
                                    .resizable()
                                    .scaledToFit()
                            }
                            
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                            
                            if firstMessageListened {
                                HStack {
                                    Text(firstAudioTranscriptPL)
                                }
                            }
                            
                            HStack {
                                Text(dateFormatter.string(from: Date())) // Replace with actual time
                                    .font(.footnote)
                                Image("no-profile-photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Button(action: {
                                    // Show overlay
                                }) {
                                    Image(systemName: "play.fill")
                                }
                                Spacer()
                                Image("audio-spectrum-2")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 10)
                            
                            if secondMessageListened {
                                HStack {
                                    Text(feedbackTranscriptPL)
                                }
                            }
                            
                            HStack {
                                Text(dateFormatter.string(from: Date())) // Replace with actual time
                                    .font(.footnote)
                                Image("no-profile-photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
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
                                .resizable()
                                .frame(width: 40, height: 50)
                        }
                        Button(action: {
                            audioURL = nil
                            showControls = false
                        }) {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 40, height: 50)
                        }
                        Button(action: {
                            showControls = false
                        }) {
                            Image(systemName: "arrow.up.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 50)
                        }
                    }
                    .padding()
                } else {
                    Button(action: toggleRecording) {
                        Image(systemName: "mic.fill")
                            .resizable()
                            .frame(width: 40, height: 60)
                            .foregroundColor(isRecording ? Color.red : Color.blue)
                    }
                }
            }
            .onAppear {
                if let savedMessagesData = UserDefaults.standard.value(forKey: "Messages") as? Data,
                   let savedMessages = try? JSONDecoder().decode([Message].self, from: savedMessagesData) {
                    self.messages = savedMessages
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("Got it")))
        }
    }
}


struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(contactName: weronikaName)
    }
}
