import Foundation

class Graph {
    var vertices: [Vertex] = []
    var edges: [Edge] = []
    
    func addVertex(position: CGPoint) {
        let newVertex = Vertex(id: vertices.count, position: position)
        vertices.append(newVertex)
    }
    
    func addEdge(from: Vertex, to: Vertex) {
        let newEdge = Edge(from: from, to: to)
        edges.append(newEdge)
    }
    
    func D1(vertex: Vertex) -> Int {
        return edges.filter { $0.from.id == vertex.id || $0.to.id == vertex.id }.count
    }
    
    func cleanUpDoubleEdges() {
        var onlyGoodEdges: [Edge] = []
        
        for edge in edges {
            var good = true
            for edge2 in onlyGoodEdges {
                if((edge2.from.id == edge.from.id && edge2.to.id == edge.to.id) || (edge2.to.id == edge.from.id && edge2.from.id == edge.to.id)) {
                    good = false
                    break
                }
            }
            if(good) {
                onlyGoodEdges.append(edge)
            }
        }
        
        self.edges = onlyGoodEdges
    }
    
    func isTree() -> Bool {
        guard !vertices.isEmpty else {
            return false
        }
        
        var visited = Set<Vertex>()
        if hasCycle(vertex: vertices[0], visited: &visited, parent: nil) {
            return false
        }

        return visited.count == vertices.count
    }
    
    private func hasCycle(vertex: Vertex, visited: inout Set<Vertex>, parent: Vertex?) -> Bool {
        visited.insert(vertex)
        
        for edge in edges where edge.from == vertex || edge.to == vertex {
            let neighbour = (edge.from == vertex) ? edge.to : edge.from
            
            if visited.contains(neighbour) {
                if neighbour != parent {
                    return true
                }
            } else {
                if hasCycle(vertex: neighbour, visited: &visited, parent: vertex) {
                    return true
                }
            }
        }
        return false
    }
    
    func removeVertex(vertex: Vertex) {
        self.edges.removeAll(where: { edge in edge.from == vertex || edge.to == vertex })
        self.vertices.removeAll(where: { v in v == vertex })
    }
    
    func replicate() -> Graph {
        let graph = Graph()
        graph.edges = self.edges
        graph.vertices = self.vertices
        return graph
    }
    
    func DT(of vertex: Vertex, in block: [Vertex]) -> Int {
        var count = 0
        
        for v in block {
            if areAdjacent(vertex, v) {
                count += 1
            }
        }
        
        return count
    }
    
    func areAdjacent(_ u: Vertex, _ v: Vertex) -> Bool {
        return edges.contains { (edge) in
            (edge.from == u && edge.to == v) || (edge.from == v && edge.to == u)
        }
    }
}

