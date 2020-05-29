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
    
    var body: some View {
        NavigationView {
            ReverseScrollView {
                VStack(spacing: 0) {
                    ForEach(self.viewModel.messages, id: \.self) { (msg) in
                        ChatMessageView(chatMessage: msg)
                            .transition(.opacity)
                            .animation(.linear(duration: 0.5))
                            .onAppear {
                                if msg == self.viewModel.newMessage {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.viewModel.speakMessage(message: msg) {
                                            print("Message spoked")
                                        }
                                    }
                                }
                            }
                    }
                }
            }
            .onAppear {
                self.viewModel.startChatting()
            }
            .background(Color(UIColor(hex: "#F9FAFB")))
            .navigationBarTitle(Text("Dialogue"), displayMode: .inline)
        }
    }
    
}

struct ChatScene_Previews: PreviewProvider {
    static var previews: some View {
        ChatScene()
            .environmentObject(ChatViewModel(dataSource: DataSource()))
    }
}

