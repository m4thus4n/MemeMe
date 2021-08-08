//
//  MemeMeHome.swift
//  MemeMe
//
//  Created by mathusan selvakumar on 08/08/2021.
//

import SwiftUI

struct MemeMeHome: View {
    @State var isPresentedFullScreen = false
    
    var body: some View {
        TabView {
            NavigationView {
                SentMemesListView()
                    .listStyle(PlainListStyle())
                    .navigationBarTitle(Text("Sent Memes"), displayMode: .inline)
                    .padding(.top)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            EditButton()
                        }
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresentedFullScreen.toggle()
                            }) {
                                Image(systemName: "plus").foregroundColor(.blue)
                            }
                            .fullScreenCover(isPresented: $isPresentedFullScreen) { MemeMeEditorView() }
                        }
                    }
            }
            .tabItem {
                Image(systemName: "list.dash")
            }
            .tag(0)
            
            NavigationView {
                SentMemesGridView()
                    .listStyle(PlainListStyle())
                    .navigationBarTitle(Text("Sent Memes"), displayMode: .inline)
                    .padding(.top)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action: {
                                isPresentedFullScreen.toggle()
                            }) {
                                Image(systemName: "plus").foregroundColor(.blue)
                            }
                            .fullScreenCover(isPresented: $isPresentedFullScreen) { MemeMeEditorView() }
                        }
                    }
            }
            .tabItem {
                Image(systemName: "square.grid.3x3")
            }
            .tag(1)
        }
    }
}

struct MemeMeHome_Previews: PreviewProvider {
    static var previews: some View {
        MemeMeHome()
    }
}
