//
//  ActivityView.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 08/08/2021.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    @ObservedObject var viewModel = MemeMeViewModel()
    
    var topText: String
    var bottomText: String
    var originalImageData: Data?
    var memedImageData: Data?
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller.completionWithItemsHandler = { (activity, completed, items, error) in
            if completed {
                save()
            }
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
    
    func save() {
        let meme = MemeMeModel.Meme(topText: topText, bottomText: bottomText, originalImageData: originalImageData, memedImageData: memedImageData)
        
        viewModel.memes.append(meme)
    }
}
