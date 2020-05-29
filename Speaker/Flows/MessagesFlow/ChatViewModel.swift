//
//  ChatViewModel.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import Combine
import SwiftUI

class ChatViewModel: ObservableObject {

    let objectWillChange = PassthroughSubject<ChatViewModel, Never>()
    
    var didChange = PassthroughSubject<Void, Never>()
    
    var newMessage: ChatMessage? {
        didSet {
            if newMessage == nil {
                self.dataSource.sendNextMessage()
            } else {
                objectWillChange.send(self)
            }
        }
    }

    @Published var messages = [ChatMessage]()
    
    private unowned var dataSource: DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        self.dataSource.add(delegate: self)
    }
    
    func startChatting() {
        self.dataSource.sendNextMessage()
    }

    func speakMessage(message: ChatMessage, complete: (() -> ())?) {
        debugPrint("speak message: \(message.content)")
        complete?()
        self.newMessage = nil
    }

}

extension ChatViewModel: DataSourceDelegate {
    
    func didRecieve(newMessage: ChatMessage) {
        self.newMessage = newMessage
        self.messages.append(newMessage)
        self.objectWillChange.send(self)
    }
    
}
