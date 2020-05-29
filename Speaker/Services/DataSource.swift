//
//  DataSource.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import Combine
import SwiftUI

class DataSource: MultiDelegates {
    
    internal var delegates = WeakArray()
    
    typealias ProtocolType = DataSourceDelegate
    
    private var messages = [ChatMessage]()
    
    let newMessage = PassthroughSubject<ChatMessage, Never>()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard
            let url = Bundle.main.url(forResource: "messages", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                messages = []
                return
        }
        
        do {
            let decoder = JSONDecoder()
            self.messages = try decoder.decode([ChatMessage].self, from: data)
        } catch {
            self.messages = []
        }
    }
    
    // MARK: Chatting
    
    func sendNextMessage() {
        guard messages.count > 0 else { return }
        
        let message = messages.remove(at: 0)
        
        delegates
            .compactMap { $0.value }
            .forEach { delegate in
                delegate.didRecieve(newMessage: message)
        }
    }
    
}

protocol DataSourceDelegate {
    
    func didRecieve(newMessage: ChatMessage)
    
}

extension DataSourceDelegate {
    
    func didRecieve(newMessage: ChatMessage) { }

}
