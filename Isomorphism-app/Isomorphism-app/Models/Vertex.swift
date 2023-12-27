//
//  Vertex.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import Foundation

struct Vertex {
    var id: Int
    var position: CGPoint
    
    func isNear(to point: CGPoint, radius: CGFloat) -> Bool {
        return self.position.distance(to: point) <= radius
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(self.x - point.x, self.y - point.y)
    }
}

