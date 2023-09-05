//
//  ContentView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 05/09/2023.
//

import SwiftUI


struct Message: Identifiable, Codable {
    var id = UUID()
    var text: String
    var timestamp: String
}

struct ContentView: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = []
    @State private var showSettings = false
    @State private var darkMode = UserDefaults.standard.bool(forKey: "DarkMode")
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Scrollable message area
                List {
                    ForEach(messages, id: \.id) { msg in
                        HStack {
                            Text(msg.text)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color.blue))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(msg.timestamp)
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
                
                // Text box & send button
                HStack {
                    TextField("Type your message...", text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Send") {
                        let timestamp = dateFormatter.string(from: Date())
                        let newMessage = Message(text: messageText, timestamp: timestamp)
                        messages.append(newMessage)
                        
                        if let encoded = try? JSONEncoder().encode(messages) {
                            UserDefaults.standard.set(encoded, forKey: "Messages")
                        }
                        messageText = ""
                    }

                }
                .padding()
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
