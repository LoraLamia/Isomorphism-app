import Foundation

class AlgorithmCertificatesGraphs: GraphIsomorphismAlgorithm {
    
    var graphOne: Graph
    var graphTwo: Graph
    var cert1: Int
    var cert2: Int
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
        cert1 = 0
        cert2 = 0
    }
    
    func areIsomorphic() -> Bool {
        let v1 = cert(G: graphOne)
        self.cert1 = v1
        let v2 = cert(G: graphTwo)
        self.cert2 = v2
        return v1 == v2
    }
    
    
    func initializePartition(for graph: Graph) -> [[Vertex]] {
        var partition: [[Vertex]] = []
        var block = [Vertex]()
        
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
            T = S.removeFirst()
            
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
        }
        
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
    
    func canon(G: Graph, P: [[Vertex]], currentBestOrdering: [[Vertex]], currentBestExists: Bool) -> ([[Vertex]], Bool) {
        var bestOrdering = currentBestOrdering
        var bestExists = currentBestExists
        
        let Q = refine(G: G, A: P)
        
        let l = Q.firstIndex(where: { $0.count > 1 }) ?? Q.count
        
        if bestExists {
            var pi1: [[Vertex]] = []
            for i in 0..<l {
                if Q[i].count == 1 {
                    pi1.append(Q[i])
                } else {
                    break
                }
            }

            let Res = compare(G: G, μ: bestOrdering, π: pi1, n: pi1.count)
            
            if Res == .worse {
                return (bestOrdering, bestExists)
            }
        }
        
        if Q.count == G.vertices.count {
            if !bestExists || compare(G: G, μ: bestOrdering, π: Q, n: G.vertices.count) == .better {
                bestOrdering = Q
                bestExists = true
            }
        } else {
            let C = Q[l]
            let D = C
            
            var R = Array(repeating: [Vertex](), count: Q.count + 1)
            
            for j in 0..<l {
                R[j] = Q[j]
            }
            
            for j in l + 1..<Q.count {
                R[j + 1] = Q[j]
            }
            
            for u in C {
                R[l] = [u]
                R[l + 1] = D.filter { $0 != u }
                
                let (tempBestOrdering, tempBestExists) = canon(G: G, P: R, currentBestOrdering: bestOrdering, currentBestExists: bestExists)
                
                if tempBestExists && (!bestExists || compare(G: G, μ: bestOrdering, π: tempBestOrdering, n: G.vertices.count) == .better) {
                    bestOrdering = tempBestOrdering
                    bestExists = tempBestExists
                }
            }
        }
        
        return (bestOrdering, bestExists)
    }

    
    
    func cert(G: Graph) -> Int {
        let startPart = initializePartition(for: G)
        let (finalOrdering, _) = canon(G: G, P: startPart, currentBestOrdering: [], currentBestExists: false)
        
        var C = 0
        var k = 0
        for j in (1..<G.vertices.count).reversed() {
            for i in (0..<j).reversed() {
                if G.areAdjacent(finalOrdering[i][0], finalOrdering[j][0]) {
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


