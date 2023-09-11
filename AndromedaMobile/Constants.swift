//
//  Constants.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 07/09/2023.
//

import Foundation


let kamilPL: String = "Kamil 🇵🇱"
let kamilEN: String = "Kamil 🇺🇸"

let formsURL = "https://forms.gle/uz4WDHekZ1C77rDt8"

let firstAudioTranscriptPL = """
hej Wera! 👋 Wraz z Kubą wpadliśmy na super pomysł. 🤩 Wkurzało nas to, że nagrywając wiadomość głosową i przerabiając ją  na tekst tracimy emocje i kontekst! 😡 Kurde, to jest mega wkurwiające! 🤬 Ale czaj to! 🤯 Wyobraź sobie, że używasz AI, które automatycznie dodaje emoji i dobiera kolor tła do tekstu. 👀 Daj mi, proszę znać co o tym sądzisz! 🙏
"""


let feedbackTranscriptPL = """
No i ogólnie kiedy odsłuchasz wiadomość, to Emoji zostają w tekście. Taki jest pomysł. 😌 Byłoby nam mega miło gdybyś opowiedział co sądzisz o tym pomyśle w GoogleForms. 😘 Link poniżej ⬇️
"""

let firstAudioTranscriptEN = """
👋 Hey babe! 👋 Kuba and I came up with an awesome idea. 🤩 It annoyed us that when recording a voice message and converting it to text, we lose emotions and context! 😡 Damn, it's fucking annoying! 🤬 But check this out! 🤯 Imagine, you're using AI that  automatically adds emojis to text and picks the background color. 👀 Let me know what you think! 🙏
"""

let feedbackTranscriptEN = """
When you’ve listened to the message, the emojis are embedded in text. 😌 Dear user! We'd be really happy if you could tell us what you think about the idea. 😘 Link below ⬇️
"""

let emojiToColorHex: [String: String] = [
    "": "FFFFFF", // white
    "🤩": "#FFD700",  // Admiration
    "😍": "#FF69B4",  // Adoration
    "🎨": "#20B2AA",  // Aesthetic Appreciation
    "😄": "#FFFF00",  // Amusement
    "😡": "#FF0000",  // Anger
    "🤨": "#D2691E",  // Annoyance
    "😰": "#0000FF",  // Anxiety
    "😳": "#4B0082",  // Awe
    "😬": "#808080",  // Awkwardness
    "😶": "#A9A9A9",  // Boredom
    "😌": "#008080",  // Calmness
    "🧠": "#FF4500",  // Concentration
    "😵‍💫": "#9400D3",  // Confusion
    "🙄": "#696969",  // Contempt
    "😊": "#32CD32",  // Contentment
    "🤤": "#FFA500",  // Craving
    "😏": "#FF6347",  // Desire
    "💪": "#000000",  // Determination
    "🙁": "#8A2BE2",  // Disappointment
    "👎": "#B22222",  // Disapproval
    "🤮": "#556B2F",  // Disgust
    "😢": "#4682B4",  // Distress
    "😕": "#708090",  // Doubt
    "🥳": "#EE82EE",  // Ecstasy
    "🥺": "#FF1493",  // Embarrassment
    "😔": "#2F4F4F",  // Empathic Pain
    "🎉": "#FFD700",  // Enthusiasm
    "😵": "#8B0000",  // Entrancement
    "😤": "#228B22",  // Envy
    "🤪": "#7FFF00",  // Excitement
    "😨": "#8B0000",  // Fear
    "🙏": "#DAA520",  // Gratitude
    "😓": "#708090",  // Guilt
    "👀": "#48D1CC",  // Interest
    "😁": "#ADFF2F",  // Joy
    "❤️": "#FF0000",  // Love
    "📺": "#8B4513",  // Nostalgia
    "🤕": "#483D8B",  // Pain
    "👑": "#EE82EE",  // Pride
    "🤯": "#4169E1",  // Realization
    "😅": "#00CED1",  // Relief
    "💘": "#FF69B4",  // Romance
    "😭": "#1E90FF",  // Sadness
    "😆": "#2E8B57",  // Sarcasm
    "🙂": "#20B2AA",  // Satisfaction
    "😑": "#778899",  // Shame
    "😦": "#B22222",  // Surprise (negative)
    "🤭": "#4B0082",  // Surprise (positive)
    "☹️": "#D3D3D3",  // Sympathy
    "😴": "#4682B4",  // Tiredness
    "🏆": "#DAA520"  // Triumph
]



let audioURLfirstAudioEN = getAudioURL(filename: "firstAudioEN", type: "m4a")
let audioURLfeedbackEN = getAudioURL(filename: "feedbackEN", type: "m4a")
let audioURLfirstAudioPL = getAudioURL(filename: "firstAudioPL", type: "m4a")
let audioURLfeedbackPL = getAudioURL(filename: "feedbackPL", type: "m4a")
