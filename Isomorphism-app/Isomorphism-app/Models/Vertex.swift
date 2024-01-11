import Foundation
import CoreGraphics

class Vertex {
    var id: Int
    var position: CGPoint
    var mark: String
    
    init(id: Int, position: CGPoint, mark: String = "") {
        self.id = id
        self.position = position
        self.mark = mark
    }
    
    func isNear(to point: CGPoint, radius: CGFloat) -> Bool {
        return self.position.distance(to: point) <= radius
    }
    
}

extension Vertex: Hashable {
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(position)
        hasher.combine(mark)
    }
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

