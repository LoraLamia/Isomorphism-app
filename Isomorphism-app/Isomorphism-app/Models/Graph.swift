import Foundation

class Graph {
    var vertices: [Vertex] = []
    var edges: [Edge] = []
    var dictX1: [Int: [Vertex]] = [:]
    var dictX2: [[Int]: [Vertex]] = [:]
    
    lazy var X: [[[Vertex]]] = {
        return [[vertices]]
    }()
    
    func addVertex(position: CGPoint) {
        let newVertex = Vertex(id: vertices.count, position: position)
        vertices.append(newVertex)
    }
    
    func addEdge(from: Vertex, to: Vertex) {
        let newEdge = Edge(from: from, to: to)
        edges.append(newEdge)
    }
    
    //radi, testirano
    func X1() {
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
        
        self.dictX1 = dict
        
        var res: [[Vertex]] = []
        let keys = dict.keys.sorted()
        for value in keys {
            res.append(dict[value]!)
        }
        
        X.append(res)
    }
    
    func X2() {
        var dict: [[Int]: [Vertex]] = [:]
        for vertex in vertices {
            let res = D2(vertex: vertex)
            if(dict[res] == nil) {
                dict[res] = [vertex]
            } else {
                var temp = dict[res]
                temp?.append(vertex)
                dict[res] = temp
            }
        }
        
        self.dictX2 = dict
        
        var res: [[Vertex]] = []
        
        
        let keys = dict.keys
        
        var myArray: [[Int]] = []
        for key in keys {
            myArray.append(key)
        }
        
        let sortedKeys = myArray.sorted { arr1, arr2 in
            
            for index in 0...arr1.count {
                if arr1[index] > arr2[index] {
                    return true
                } else if arr1[index] < arr2[index] {
                    return false
                }
            }
            return true
        }

        for value in sortedKeys {
            res.append(dict[value]!)
        }
        
        X.append(res)
        
        var isSubSet = false
        for x2 in X[2] {
            isSubSet = false
            let setX2 = NSOrderedSet(array: x2)
            for x1 in X[1] {
                let setX1 = NSOrderedSet(array: x1)
                if(setX2.isSubset(of: setX1)) {
                    isSubSet = true
                    break;
                }
            }
            
            if(!isSubSet) {
                break
            }
            
        }
        if(!isSubSet) {
            print("Neki od vrhova ne pripadaju istom bloku jer u prethodnom koraku nisu bili u istom bloku.")
        }
        
        
    }
    
    //radi, testirano, oblik: stupanj vrha
    func D1(vertex: Vertex) -> Int {
        return edges.filter { $0.from.id == vertex.id || $0.to.id == vertex.id }.count
    }
    
    func D2(vertex: Vertex) -> [Int] {
        let maxDegree = vertices.count - 1
        var degreeCount = [Int](repeating: 0, count: maxDegree)
        
        for edge in edges {
            if edge.from.id == vertex.id {
                degreeCount[D1(vertex: edge.to)-1] += 1
            } else if edge.to.id == vertex.id {
                degreeCount[D1(vertex: edge.from)-1] += 1
            }
        }
        return degreeCount
    }
    
}

extension Graph {
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
}
