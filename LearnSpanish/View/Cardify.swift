//
//  Cardify.swift
//  LearnSpanish
//
//  Created by IS 543 on 10/18/24.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isFaceUp: Bool {
        rotation < 270
    }
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 360
    }
    
    func body(content: Content) -> some View {
        
        GeometryReader { geometry in
            ZStack {
                if isFaceUp{
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke()
                }
                content.opacity(isFaceUp ? 1 : 1)
            }
            
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (x: 1.0, y: 1.0, z: 0.0))
    }
    
    //MARK: - Drawing constants
    
private func cornerRadius(for size: CGSize) -> Double {
    min(size.width, size.height) * 0.08
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

