import Foundation
import CoreGraphics

struct Vertex {
    var id: Int
    var position: CGPoint
    var mark: [Int: String] = [:]
    
    func isNear(to point: CGPoint, radius: CGFloat) -> Bool {
        return self.position.distance(to: point) <= radius
    }
    
}

extension Vertex: Hashable {
    
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(self.x - point.x, self.y - point.y)
    }
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

