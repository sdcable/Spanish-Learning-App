//
//  LineProgress.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/18/24.
//

import SwiftUI

struct LineProgress: Shape {
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width * progress  // Shrink the line width based on progress
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.minX + width, y: rect.midY)
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        return path
    }
}
#Preview {
    LineProgress(progress: 0.5)
}
