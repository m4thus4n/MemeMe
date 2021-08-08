//
//  SentMemesGridView.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 08/08/2021.
//

import SwiftUI

struct SentMemesGridView: View {
    @ObservedObject var viewModel = MemeMeViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(viewModel.memes, id: \.self) { meme in
                    GridViewMeme(memeImageData: meme.memedImageData)
                }
            }
        }
    }
}

struct GridViewMeme: View {
    var memeImageData: Data?
    
    var body: some View {
        HStack {
            if let memeImageData = memeImageData, let memeImage = UIImage(data: memeImageData) {
                Image(uiImage: memeImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct SentMemesGridView_Previews: PreviewProvider {
    static var previews: some View {
        SentMemesGridView()
    }
}
