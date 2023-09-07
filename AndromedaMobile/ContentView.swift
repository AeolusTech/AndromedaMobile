//
//  ContentView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 05/09/2023.
//

import AVFoundation
import SwiftUI
import Foundation


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


struct ContentView: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = []
    @State private var showSettings = false
    @State private var darkMode = UserDefaults.standard.bool(forKey: "DarkMode")
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

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

    // FIXME: currently getting 400 response code = bad request
    func uploadAudio() {
        guard let audioURL = self.audioURL else { return }

        let headers = [
          "accept": "application/json",
          "content-type": "multipart/form-data; boundary=---011000010111000001101001",
          "X-Hume-Api-Key": "niMgijWBGoV63fLvAHjrcDXS7Z8uo8Grf4xnwysYmLobobcd"
        ]
        
        let boundary = "---011000010111000001101001"
        
        var request = URLRequest(url: URL(string: "https://api.hume.ai/v0/batch/jobs")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

        var body = Data()

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"audio\"; filename=\"audio\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
        do {
            let audioData = try Data(contentsOf: audioURL)
            body.append(audioData)
        } catch {
            print("Audio data could not be read")
            return
        }
        
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status: \(httpResponse.statusCode)")
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let transcript = json?["transcript"] as? String {
                        DispatchQueue.main.async {
                            self.messages.append(Message(audioURL: audioURL, transcript: transcript, timestamp: dateFormatter.string(from: Date())))
                        }
                    }
                } catch {
                    print("JSON decoding failed: \(error)")
                }
            }
        }
        
        dataTask.resume()
    }


    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(messages, id: \.id) { msg in
                        HStack {
                            // TODO: Existing code to display message...
                            Button(action: {
                                self.audioRecorder.playAudio(path: msg.audioURL)
                            }) {
                                Image(systemName: "play.fill")
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
                            uploadAudio()
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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error"), message: Text(self.alertMessage), dismissButton: .default(Text("Got it")))
        }
    }
}

struct SettingsView: View {
    @Binding var darkMode: Bool
    @State private var dummyToggle1 = false
    @State private var dummyToggle2 = false
    @State private var dummyToggle3 = false
    
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
                
                Toggle("Dummy Toggle 1", isOn: $dummyToggle1)
                Toggle("Dummy Toggle 2", isOn: $dummyToggle2)
                Toggle("Dummy Toggle 3", isOn: $dummyToggle3)

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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SettignsView_Previews: PreviewProvider {
    @State static var mockDarkMode = false // Or true, depending on what you want to preview

    
    static var previews: some View {
        SettingsView(darkMode: $mockDarkMode)
    }
}
