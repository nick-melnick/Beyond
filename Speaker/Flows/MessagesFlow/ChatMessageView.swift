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
        HStack(alignment: .bottom, spacing: 0) {
            Text(self.chatMessage.content)
                .padding(10)
                .padding(.leading, 11)
                .foregroundColor(.gray)
                .background(BubbleShare(color: Color(UIColor(hex: "#FDFDFE")), cornerRadius: 5.0, cornerWidth: 11, cornerHeight: 18))
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 30, trailing: 0))
    }
    
}

#if DEBUG
struct ChatMessageView_Previews : PreviewProvider {
    static var previews: some View {
        ChatMessageView(chatMessage: ChatMessage(content: "Test lksd fjf ;asjf saljf ;lsjf lsjf ls flsjkf sd;lfj a;sjkf lk;sjf sdlf j;sjf asdjf"))
    }
}

#endif
