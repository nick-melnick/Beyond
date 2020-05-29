//
//  ChatMessageView.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

struct ChatMessageView: View {
    
    var chatMessage: ChatMessage
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            Text(self.chatMessage.content)
                .padding(10)
                .padding(.leading, 11)
                .foregroundColor(.gray)
                .background(BubbleShare(color: Color.white, cornerRadius: 5.0, cornerWidth: 11, cornerHeight: 18))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding()
        .padding(.bottom, 10)
    }
    
}

#if DEBUG
struct ChatMessageView_Previews : PreviewProvider {
    static var previews: some View {
        ChatMessageView(chatMessage: ChatMessage(content: "Test lksd fjf ;asjf saljf ;lsjf lsjf ls flsjkf sd;lfj a;sjkf lk;sjf sdlf j;sjf asdjf"))
    }
}

#endif
