//
//  AudioHandler.swift
//  AndromedaMobile
//
//  Created by Kamil Kuczaj on 07/09/2023.
//

import Foundation


func getAudioURL(filename: String, type: String) -> URL? {
    return Bundle.main.url(forResource: filename, withExtension: type)
}

