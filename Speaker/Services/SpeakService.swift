//
//  SpeakService.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import Foundation
import AVFoundation

class SpeakService: NSObject, MultiDelegates {
    
    internal var delegates = WeakArray()
    
    typealias ProtocolType = SpeakServiceDelegate
    
    private lazy var speechSynthesizer:AVSpeechSynthesizer = {
        let speaker = AVSpeechSynthesizer()
        speaker.delegate = self
        return speaker
    }()
    
    var isSpeaking: Bool {
        return self.speechSynthesizer.isSpeaking
    }
    
    private var message: String?
    
    func speak(message: String) {
        self.message = message
        let speechUtterance = AVSpeechUtterance(string: message)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0

        self.speechSynthesizer.speak(speechUtterance)
    }
    
    func stopSpeak() {
        speechSynthesizer.stopSpeaking(at: .word)
    }
    
}

extension SpeakService: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        delegates.compactMap({ $0.value }).forEach({ delegate in
            delegate.didStartSpeak(message: self.message)
        })
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegates.compactMap({ $0.value }).forEach({ delegate in
            delegate.didFinishSpeak(message: self.message)
        })
    }
    
}

protocol SpeakServiceDelegate {
    func didStartSpeak(message: String?)
    func didFinishSpeak(message: String?)
}

extension SpeakServiceDelegate {
    func didStartSpeak(message: String?) {}
    func didFinishSpeak(message: String?) {}
}
