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
    
    private var speakService: SpeakService?
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
        self.dataSource.add(delegate: self)
    }
    
    func startChatting() {
        self.dataSource.sendNextMessage()
    }

    private var speakFinishedCallback: (() -> Void)?
    
    func speakMessage(message: ChatMessage, complete: @escaping () -> Void) {
        if self.speakService == nil {
            self.speakService = SpeakService()
            self.speakService?.add(delegate: self)
        } else {
            self.speakService?.stopSpeak()
        }
        self.speakService?.speak(message: message.content)
        self.speakFinishedCallback = complete
    }

}

extension ChatViewModel: DataSourceDelegate {
    
    func didRecieve(newMessage: ChatMessage) {
        self.newMessage = newMessage
        self.messages.append(newMessage)
        self.objectWillChange.send(self)
    }
    
}

extension ChatViewModel: SpeakServiceDelegate {
    
    func didStartSpeak(message: String?) {
        print("Start speak message: \(String(describing: message))")
    }
    
    func didFinishSpeak(message: String?) {
        speakFinishedCallback?()
        self.newMessage = nil
    }
    
}
