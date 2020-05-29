//
//  ReverseScrollView.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

struct ReverseScrollView<Content>: View where Content: View {
    @State private var contentHeight: CGFloat = CGFloat.zero
    
    var content: () -> Content
    
    func offset(outerheight: CGFloat, innerheight: CGFloat) -> CGFloat {
        return -(innerheight/2 - outerheight/2)
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            self.content()
                .modifier(ViewHeightKey())
                .onPreferenceChange(ViewHeightKey.self) { self.contentHeight = $0 }
                .frame(height: outerGeometry.size.height)
                .offset(y: self.offset(outerheight: outerGeometry.size.height, innerheight: self.contentHeight))
                .animation(.linear(duration: 0.5))
                .clipped()
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

struct ReverseScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ReverseScrollView {
            ChatMessageView(chatMessage: ChatMessage(content: "Test"))
        }
        .previewLayout(.sizeThatFits)
    }
}
