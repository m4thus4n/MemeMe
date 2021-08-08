//
//  MemeMeModel.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 07/08/2021.
//

import Foundation

struct MemeMeModel {
    
    var memesList: [Meme] = []
    
    struct Meme: Hashable, Identifiable {
        var topText: String
        var bottomText: String
        var originalImageData: Data?
        var memedImageData: Data?
        
        let id = UUID()
    }
}
