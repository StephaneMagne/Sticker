//
//  TransformStickerMotionEffect.swift
//  Sticker
//
//  Created by Stephane Magne on 2025-08-12.
//

import Foundation

import SwiftUI

public struct TransformStickerMotionEffect: StickerMotionEffect {

    @Binding var transform: StickerTransform

    let intensity: Double

    @Environment(\.stickerShaderUpdater) private var shaderUpdater

    public func body(content: Content) -> some View {
        return content
            .withViewSize { view, size in
                let xRotation: Double = (transform.x / size.width) * intensity
                let yRotation: Double = (transform.y / size.height) * intensity
                view
                    .rotation3DEffect(.radians(xRotation), axis: (0, 1, 0))
                    .rotation3DEffect(.radians(yRotation), axis: (-1, 0, 0))
            }
            .onChange(of: transform) {
                print("(update shader) manual.transform -> x: \(transform.x), y: \(transform.y)")
                shaderUpdater.update(with: transform)
            }
    }
}

public extension StickerMotionEffect where Self == TransformStickerMotionEffect {

    static func transform(_ stickerTransform: Binding<StickerTransform> = .constant(.neutral), intensity: Double = 1) -> Self {
        TransformStickerMotionEffect(transform: stickerTransform, intensity: intensity)
    }
}
