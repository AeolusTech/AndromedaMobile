//
//  ContentView.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 05/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var messageText: String = ""
    @State private var messages: [(text: String, timestamp: String)] = []
    @State private var darkMode: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Scrollable message area
                List {
                    ForEach(messages, id: \.timestamp) { msg in
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
                        let timestamp = "\(Date())"
                        messages.append((text: messageText, timestamp: timestamp))
                        messageText = ""
                    }
                }
                .padding()
            }
            .navigationBarItems(trailing:
                HStack {
                    // Dark mode toggle
                    Toggle(isOn: $darkMode) {
                        Text("Dark Mode")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
            )
            .preferredColorScheme(darkMode ? .dark : .light)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
