//
//  ChatMessageShapes.swift
//  Speaker
//
//  Created by Nick Melnick on 29.05.2020.
//  Copyright © 2020 Nick Melnick. All rights reserved.
//

import SwiftUI

struct BubbleShare: View {
    
    var color: Color
    var cornerRadius: CGFloat = 0.0
    var cornerWidth: CGFloat = 0.0
    var cornerHeight: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.cornerRadius, h/2), w/2)
                let tl = min(min(self.cornerRadius, h/2), w/2)
                let br = min(min(self.cornerRadius, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: h))
                path.addLine(to: CGPoint(x: self.cornerWidth, y: h - self.cornerHeight))
                path.addLine(to: CGPoint(x: self.cornerWidth, y: tl))
                path.addArc(center: CGPoint(x: tl + self.cornerWidth, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 1, y: 1)
        }
    }
}
