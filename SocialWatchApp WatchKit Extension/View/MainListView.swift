//
//  MainListView.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 14.06.2022.
//

import SwiftUI
import CachedAsyncImage
import Combine

struct MainListView: View {
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    ForEach(viewModel.products, id: \.self) { item in
                        CustomRowView(product: item)
                        Divider()
                            .background(.white)
                            .frame(height: 2)
                    }
                    .listRowBackground(Color.gray)
                }
            }
        }
    }
}

struct CustomRowView: View {
    
    var product: Product
    @State private var isPresented = false
    
    
    var body: some View {
        VStack() {
            HStack() {
                CachedAsyncImage(url: URL(string: product.thumbnail), urlCache: .imageCache) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 24, height: 24)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(product.title)
                    .font(.title3)
                    .foregroundColor(Color.black)
                    .lineLimit(1)
            }
            .padding(.init(top: 5, leading: 10, bottom: 0, trailing: 5))
            .background(.clear)
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 8) {
                GeometryReader { geo in
                    PagingView(config: .init(margin: 0, spacing: 0)) {
                        ForEach(product.images, id: \.self) { image in
                            CachedAsyncImage(url: URL(string: image)) { image in
                                image.resizable()
                                    .background(.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } placeholder: {
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .background(.gray)
                            .gesture(
                                TapGesture()
                                    .onEnded { _ in
                                        isPresented.toggle()
                                    }
                            )
                            
                        }
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: geo.size.width, height: geo.size.height)
                        .mask(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                .frame(width: 200, height: 158)
                Text(product.productDescription)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .lineLimit(5)
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            ModalView(images: product.images)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") { self.isPresented.toggle() }
                    }
                })
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var images: [String]
    
    var body: some View {
        GeometryReader { geo in
            TabView {
                ForEach(images, id: \.self) { image in
                    CachedAsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                            .background(.clear)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: geo.size.height - 60, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .background(.gray)
                    .padding(.init(top: 50, leading: 10, bottom: 30, trailing: 10))
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(maxWidth: .infinity)
                .frame(height: geo.size.height, alignment: .center)
                .background(.gray)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(maxWidth: .infinity)
            .frame(height: geo.size.height, alignment: .center)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}

