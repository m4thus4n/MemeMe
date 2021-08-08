//
//  SentMemesListView.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 08/08/2021.
//

import SwiftUI

struct SentMemesListView: View {
    @ObservedObject var viewModel = MemeMeViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.memes, id: \.self) { meme in
                ListViewMeme(memedImageData: meme.memedImageData, topText: meme.topText, bottomText: meme.bottomText)
            }
        }
    }
}

struct ListViewMeme: View {
    var memedImageData: Data?
    var topText: String
    var bottomText: String
    
    var body: some View {
        HStack {
            if let memedImageData = memedImageData, let memedImage = UIImage(data: memedImageData) {
                Image(uiImage: memedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(4)
            }
            Text(topText + " " + bottomText)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
    }
}

struct SentMemesListView_Previews: PreviewProvider {
    static var previews: some View {
        SentMemesListView()
    }
}
