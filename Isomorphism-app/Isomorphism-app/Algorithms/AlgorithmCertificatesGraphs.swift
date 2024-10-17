import Foundation

class AlgorithmCertificatesGraphs: GraphIsomorphismAlgorithm {
    
    var graphOne: Graph
    var graphTwo: Graph
    var bestOrdering1: [[Vertex]]
    var bestExists = false
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
        self.bestOrdering1 = []
    }
    
    func areIsomorphic() -> Bool {
        let A = initializePartition(for: graphOne)
        var _ = refine(G: graphOne, A: A)
        return true
    }
    
    
    func initializePartition(for graph: Graph) -> [[Vertex]] {
        var partition: [[Vertex]] = []
        var block = [Vertex]()
        
        //        block.append(graph.vertices[0])
        //        var block2 = [Vertex]()
        //        for i in 1..<graph.vertices.count {
        //            let vertex = graph.vertices[i]
        //            block2.append(vertex)
        //        }
        //        partition.append(block)
        //        partition.append(block2)
        
        for i in 0..<graph.vertices.count {
            let vertex = graph.vertices[i]
            block.append(vertex)
        }
        
        partition.append(block)
        return partition
    }
    
    func refine(G: Graph, A: [[Vertex]]) -> [[Vertex]] {
        var B = A
        var S = [[Vertex]]()
        
        for block in B {
            S.append(block)
        }
        
        var T: [Vertex]
        
        while !S.isEmpty {
            T = S.removeLast()
            
            for (i, block) in B.enumerated() {
                var L = Array(repeating: [Vertex](), count: G.vertices.count)
                
                for vertex in block {
                    let degreeInT = G.DT(of: vertex, in: T)
                    L[degreeInT].append(vertex)
                }
                
                let nonEmptyBlocks = L.filter { !$0.isEmpty }
                
                if nonEmptyBlocks.count > 1 {
                    B[i] = nonEmptyBlocks[0]
                    S.append(nonEmptyBlocks[0])
                    
                    for h in 1..<nonEmptyBlocks.count {
                        let newBlock = nonEmptyBlocks[h]
                        
                        if !B.contains(where: { $0 == newBlock }) {
                            B.insert(newBlock, at: i + h)
                        }
                        
                        if !S.contains(where: { $0 == newBlock }) {
                            S.append(newBlock)
                        }
                    }
                }
            }
            
            print("Trenutna particija B: \(B.map { $0.map { $0.id } })")
            print("Trenutna particija S: \(S.map { $0.map { $0.id } })")
            print("--------------")
        }
        
        print("Konačna ekvidistantna particija B: \(B.map { $0.map { $0.id } })")
        print("Konačna ekvidistantna particija S: \(S.map { $0.map { $0.id } })")
        print("--------------")
        return B
    }
    
    func compare(G: Graph, μ: [[Vertex]], π: [[Vertex]], n: Int) -> ComparisonResult {
        for j in 1..<n {
            for i in 0..<j {
                let x = G.areAdjacent(μ[i][0], μ[j][0]) ? 1 : 0
                let y = G.areAdjacent(π[i][0], π[j][0]) ? 1 : 0
                
                if x < y {
                    return .worse
                } else if x > y {
                    return .better
                }
            }
        }
        return .equal
    }
    
    func canon(G: Graph, P: [[Vertex]]) {

        var Q = refine(G: G, A: P)
        
        var l = Q.firstIndex(where: { $0.count > 1 })

        if bestExists {
            var pi1 = Array(repeating: Vertex(id: -1, position: CGPoint()), count: G.vertices.count)
            for i in 0..<G.vertices.count {
                if Q[i].count == 1 {
                    pi1[i] = Q[i][0]
                } else {
                    break
                }
                
            }

            let Res = compare(G: G, μ: bestOrdering1, π: [pi1], n: pi1.count)
            
            if Res == .worse {
                return
            }
        }
        if Q.count == G.vertices.count {
            
            if !bestExists {
                bestOrdering1 = Array(repeating: [Vertex](), count: G.vertices.count)
                for i in 0..<G.vertices.count {
                    bestOrdering1[i] = Q[i]
                }
                bestExists = true
            } else {
                
                var pi1 = Array(repeating: Vertex(id: -1, position: CGPoint()), count: G.vertices.count)
                for i in 0..<G.vertices.count {
                    pi1[i] = Q[i][0]
                }
                
                let Res = compare(G: G, μ: bestOrdering1, π: [pi1], n: G.vertices.count)
                
                if Res == .better {
                    bestOrdering1 = Q
                    bestExists = true
                }
            }
            
        } else {
            if let l = l {
                var C = Q[l]
                var D = C
                
                var R = Array(repeating: [Vertex](), count: Q.count + 1)  // R je novo polje s kapacitetom
                
                for j in 0..<l {
                    R[j] = Q[j]
                }
                
                for j in l + 1..<Q.count {
                    R[j + 1] = Q[j]
                }
                
                for u in C {

                    R[l] = [u]
                    R[l + 1] = D.filter { $0 != u }
                    
                    canon(G: G, P: R)
                }
                    
            }
        }
        
    }
    
    
    func cert(G: Graph) -> Int {
        var startPart = initializePartition(for: G)
        canon(G: G, P: startPart)
        var C = 0
        var k = 0
        
        for j in (1..<G.vertices.count).reversed() {
            for i in (0..<j).reversed() {
                if(G.areAdjacent(bestOrdering1[i][0],bestOrdering1[j][0])) {
                    C += 1 << k
                }
                k += 1
            }
        }
        
        return C
    }
    
    
    
}


enum ComparisonResult {
    case better
    case worse
    case equal
}


