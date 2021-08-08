//
//  MemeMeEditorView.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 07/08/2021.
//

import SwiftUI

struct MemeMeEditorView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
        
    @State var uiImage: UIImage?
    @State private var topText = "TOP"
    @State private var bottomText = "BOTTOM"
    @State private var topTextEdited = false
    @State private var bottomTextEdited = false
    @State var items: [Any] = []
    
    var paddingText: CGFloat {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            return 75
        } else if horizontalSizeClass == .regular && verticalSizeClass == .compact {
            return 0
        } else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return 75
        }
        return 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if uiImage != nil {
                    meme
                } else {
                    memeWithoutImg
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    AnimatedActionButton(title: "Share", systemImage: "square.and.arrow.up") {
                        items.removeAll()
                        let snapshot = meme.snapshot()
                        items.append(snapshot)
                        sharedMeme = MemeMeModel.Meme(topText: topText, bottomText: bottomText, originalImageData: uiImage?.pngData(), memedImageData: snapshot.pngData())
                    }
                    .disabled(uiImage != nil ? false : true)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    AnimatedActionButton(title: "Cancel", systemImage: nil) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    if Camera.isAvailable {
                        AnimatedActionButton(title: "Take Photo", systemImage: "camera.fill") {
                            backgroundPicker = .camera
                        }
                    }
                    Spacer()
                    if PhotoLibrary.isAvailable {
                        AnimatedActionButton(title: "Album", systemImage: nil) {
                            backgroundPicker = .library
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(item: $backgroundPicker) { pickerType in
            switch pickerType {
            case .camera: Camera(handlePickedImage: { image in handlePickedBackgroundImage(image) })
            case .library: PhotoLibrary(handlePickedImage: { image in handlePickedBackgroundImage(image) })
            }
        }
        .sheet(item: $sharedMeme) { meme in
            ActivityView(topText: meme.topText, bottomText: meme.bottomText, originalImageData: meme.originalImageData, memedImageData: meme.memedImageData, items: items)
        }
    }
    
    @State private var backgroundPicker: BackgroundPickerType?
    @State var sharedMeme: MemeMeModel.Meme?
    
    enum BackgroundPickerType: Identifiable {
        case camera
        case library
        var id: BackgroundPickerType { self }
    }
    
    private func handlePickedBackgroundImage(_ image: UIImage?) {
        if let image = image {
            uiImage = image
        }
        backgroundPicker = nil
    }
    
    var meme: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            Group {
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
            
            VStack {
                ZStack {
                    Group {
                        Text(topText)
                            .offset(x: 1, y: 1)
                        Text(topText)
                            .offset(x: -1, y: -1)
                        Text(topText)
                            .offset(x: -1, y: 1)
                        Text(topText)
                            .offset(x: 1, y: -1)
                    }
                    .foregroundColor(.black)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    
                    Text(topText)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                        .foregroundColor(.white)
                    
                    TextField("", text: $topText, onEditingChanged: { editing in
                        if editing && !topTextEdited {
                            self.$topText.wrappedValue = ""
                            topTextEdited = true
                        }
                    })
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .foregroundColor(.clear)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.size.width * 3/4)
                    .padding(.vertical)
                }
                .padding(.top, paddingText)
                
                Spacer()
                
                ZStack {
                    ZStack {
                        Text(bottomText)
                            .offset(x: 1, y: 1)
                        Text(bottomText)
                            .offset(x: -1, y: -1)
                        Text(bottomText)
                            .offset(x: -1, y: 1)
                        Text(bottomText)
                            .offset(x: 1, y: -1)
                    }
                    .foregroundColor(.black)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    
                    Text(bottomText)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                        .foregroundColor(.white)
                    
                    TextField("", text: $bottomText, onEditingChanged: { editing in
                        if editing && !bottomTextEdited {
                            self.$bottomText.wrappedValue = ""
                            bottomTextEdited = true
                        }
                    })
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .foregroundColor(.clear)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.size.width * 3/4)
                    .padding(.vertical)
                }
                .padding(.bottom, paddingText)
            }
        }
    }
    
    var memeWithoutImg: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            VStack {
                ZStack {
                    ZStack {
                        Text(topText)
                            .offset(x: 1, y: 1)
                        Text(topText)
                            .offset(x: -1, y: -1)
                        Text(topText)
                            .offset(x: -1, y: 1)
                        Text(topText)
                            .offset(x: 1, y: -1)
                    }
                    .foregroundColor(.black)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    
                    Text(topText)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                        .foregroundColor(.white)
                    
                    TextField("", text: $topText, onEditingChanged: { editing in
                        if editing && !topTextEdited {
                            self.$topText.wrappedValue = ""
                            topTextEdited = true
                        }
                    })
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .foregroundColor(.clear)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.size.width * 3/4)
                    .padding(.vertical)
                }
                .padding(.top, paddingText)
                
                Spacer()
                
                ZStack {
                    Group {
                        Text(bottomText)
                            .offset(x: 1, y: 1)
                        Text(bottomText)
                            .offset(x: -1, y: -1)
                        Text(bottomText)
                            .offset(x: -1, y: 1)
                        Text(bottomText)
                            .offset(x: 1, y: -1)
                    }
                    .foregroundColor(.black)
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    
                    Text(bottomText)
                        .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                        .foregroundColor(.white)
                    
                    TextField("", text: $bottomText, onEditingChanged: { editing in
                        if editing && !bottomTextEdited {
                            self.$bottomText.wrappedValue = ""
                            bottomTextEdited = true
                        }
                    })
                    .font(.custom("HelveticaNeue-CondensedBlack", size: 40))
                    .foregroundColor(.clear)
                    .autocapitalization(UITextAutocapitalizationType.allCharacters)
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.size.width * 3/4)
                    .padding(.vertical)
                }
                .padding(.bottom, paddingText)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemeMeEditorView()
    }
}
