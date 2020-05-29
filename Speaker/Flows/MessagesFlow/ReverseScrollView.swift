//
//  ReverseScrollView.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

struct ReverseScrollView<Content>: View where Content: View {
    var content: () -> Content
    
    var body: some View {
        GeometryReader { outerGeometry in
            // Render the content
            //  ... and set its sizing inside the parent
            self.content()
                .frame(height: outerGeometry.size.height)
                .clipped()
        }
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
