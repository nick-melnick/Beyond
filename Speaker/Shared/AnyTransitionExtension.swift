//
//  AnyTransitionExtension.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    
    static var slideUpOpacity: AnyTransition {
        let transition = AnyTransition.move(edge: .bottom).animation(.linear(duration: 0.2))
            .combined(with: .opacity)
        return transition
    }
    
}
