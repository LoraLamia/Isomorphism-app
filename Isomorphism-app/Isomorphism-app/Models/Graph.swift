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
    
    //radi, testirano
    func X1() -> [[Vertex]] {
        var dict: [Int: [Vertex]] = [:]
        
        for vertex in vertices {
            let res = D1(vertex: vertex)
            if(dict[res] == nil) {
                dict[res] = [vertex]
            } else {
                var temp = dict[res]
                temp?.append(vertex)
                dict[res] = temp
            }
        }
        var res: [[Vertex]] = []
        let keys = dict.keys.sorted()
        for value in keys {
            res.append(dict[value]!)
        }
        return res
    }
    
    //radi, testirano, oblik: stupanj vrha
    func D1(vertex: Vertex) -> Int {
        return edges.filter { $0.from.id == vertex.id || $0.to.id == vertex.id }.count
    }
    
    //radi, testirano, oblik: [br susjednih vrhova st=0, br susjednih vrhova st=1, ..., br susjednih vrhova st=n-1]
    func D2(vertex: Vertex) -> [Int] {
        let maxDegree = vertices.count - 1
        var degreeCount = [Int](repeating: 0, count: maxDegree + 1)
        
        for edge in edges {
            if edge.from.id == vertex.id {
                degreeCount[D1(vertex: edge.to)] += 1
            } else if edge.to.id == vertex.id {
                degreeCount[D1(vertex: edge.from)] += 1
            }
        }
        return degreeCount
    }
    
}
