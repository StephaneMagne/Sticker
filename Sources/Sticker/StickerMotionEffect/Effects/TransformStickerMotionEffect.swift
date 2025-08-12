//
//  TransformStickerMotionEffect.swift
//  Sticker
//
//  Created by Stephane Magne on 2025-08-12.
//

import Foundation

import SwiftUI

public struct TransformStickerMotionEffect: StickerMotionEffect {

    @State private var transform: StickerTransform = .neutral

    let intensity: Double

    @Environment(\.stickerShaderUpdater) private var shaderUpdater

//    @State private var hasPresented = false

    init(transform: StickerTransform, intensity: Double) {
        self.transform = transform
        self.intensity = intensity
    }

    public func body(content: Content) -> some View {
        print("manual.transform -> x: \(transform.x), y: \(transform.y)")
        return content
            .withViewSize { view, size in
//                if hasPresented {
                    let xRotation: Double = (transform.x / size.width) * intensity
                    let yRotation: Double = (transform.y / size.height) * intensity
                    view
                        .rotation3DEffect(.radians(xRotation), axis: (0, 1, 0))
                        .rotation3DEffect(.radians(yRotation), axis: (-1, 0, 0))
//                } else {
//                    view
//                }
            }
            .onAppear {
                shaderUpdater.update(with: transform)
//                hasPresented = true
            }
    }
}

public extension StickerMotionEffect where Self == TransformStickerMotionEffect {

    static func transform(_ stickerTransform: StickerTransform = .neutral, intensity: Double = 1) -> Self {
        TransformStickerMotionEffect(transform: stickerTransform, intensity: intensity)
    }
}
