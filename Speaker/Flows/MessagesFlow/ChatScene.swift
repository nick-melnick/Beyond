//
//  ChatScene.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

struct ChatScene: View {
    
    @EnvironmentObject var viewModel: ChatViewModel
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(viewModel.messages, id: \.self) { (msg) in
                    ChatMessageView(chatMessage: msg)
                        .onAppear {
                            if msg == self.viewModel.newMessage {
                                self.viewModel.speakMessage(message: msg) {
                                    print("Message spoked")
                                }
                            }
                        }
                }
            }
            .onAppear {
                debugPrint(self.viewModel.messages)
                self.viewModel.startChatting()
            }
        }
    }
    
}

struct ChatScene_Previews: PreviewProvider {
    static var previews: some View {
        ChatScene()
            .environmentObject(ChatViewModel(dataSource: DataSource()))
    }
}
