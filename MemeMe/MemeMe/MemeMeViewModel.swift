//
//  MemeMeViewModel.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 07/08/2021.
//

import SwiftUI

class MemeMeViewModel: ObservableObject {
    @Published var memes: [MemeMeModel.Meme] = model.memesList
    
    static private var model = MemeMeModel()
}
