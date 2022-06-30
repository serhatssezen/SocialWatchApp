//
//  PagingView.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 1.07.2022.
//

import Foundation
import SwiftUI

public struct PagingView<Views: View>: View {
    public typealias Config = _PagingViewConfig
    public typealias PageIndex = _VariadicView.Children.Index
    
    private let tree: _VariadicView.Tree<Root, Views>
    
    public init(
        config: Config = Config(),
        page: Binding<PageIndex>? = nil,
        @ViewBuilder _ content: () -> Views
    ) {
        tree = _VariadicView.Tree(
            Root(config: config, page: page),
            content: content
        )
    }
    
    public init(
        direction: _PagingViewConfig.Direction,
        page: Binding<PageIndex>? = nil,
        @ViewBuilder _ content: () -> Views
    ) {
        tree = _VariadicView.Tree(
            Root(config: .init(direction: direction), page: page),
            content: content
        )
    }
    
    public var body: some View { tree }
    
    struct Root: _VariadicView.UnaryViewRoot {
        let config: Config
        let page: Binding<PageIndex>?
        @GestureState private var translation: CGFloat = 0

        func body(children: _VariadicView.Children) -> some View {
            VStack {
                _PagingView(
                    config: config,
                    page: page,
                    views: children
                )
                .offset(x: self.translation)
               
                Spacer()
                HStack {
                    ForEach(0..<children.count, id: \.self) { index in
                        Circle()
                            .fill(index == 0 ? Color.white : Color.black)
                            .frame(width: 2, height: 2)
                    }
                }
            }
        }
    }
}
