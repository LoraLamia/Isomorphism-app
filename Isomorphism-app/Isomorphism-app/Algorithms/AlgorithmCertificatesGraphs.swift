import Foundation

class AlgorithmCertificatesGraphs: GraphIsomorphismAlgorithm {
    
    var graphOne: Graph
    var graphTwo: Graph
    var isomorphic: Bool = true
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
        
    }
    
    func areIsomorphic() -> Bool {
        let A = initializePartition(for: graphOne)
        var _ = refine(G: graphOne, A: A)
        return true
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
    
    func refine(G: Graph, A: [[Vertex]]) {
        var B = A
        var S = [[Vertex]]()
        var first = true
        
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
                    if first {
                        S.insert(nonEmptyBlocks[0], at: 0)
                    } else {
                        S.append(nonEmptyBlocks[0])
                    }
                    
                    var j = i
                    for h in 1..<nonEmptyBlocks.count {
                        j += 1

                        if !B.contains(where: { $0 == nonEmptyBlocks[h] }) {
                            B.insert(nonEmptyBlocks[h], at: j)
                        }
                        
                        if !S.contains(where: { $0 == nonEmptyBlocks[h] }) {
                            if first {
                                S.insert(nonEmptyBlocks[h], at: 0)
                            } else {
                                S.append(nonEmptyBlocks[h])
                            }
                        }
                    }
                    first = false
                }
            }
                    
            print("Trenutna particija B: ")
            for (index, block) in B.enumerated() {
                let blockIds = block.map { $0.id }
                print("Blok \(index): \(blockIds)")
            }
            print("--------------")
            print("Trenutna particija S: ")
            for (index, block) in S.enumerated() {
                let blockIds = block.map { $0.id }
                print("Blok \(index): \(blockIds)")
            }
            print("--------------")

            if S.isEmpty {
                break
            }
        }
        
        print("Konačna ekvidistantna particija B:")
        for (index, block) in B.enumerated() {
            let blockIds = block.map { $0.id }
            print("Blok \(index): \(blockIds)")
        }
        print("--------------")
        print("Konačna ekvidistantna particija S:")
        for (index, block) in S.enumerated() {
            let blockIds = block.map { $0.id }  
            print("Blok \(index): \(blockIds)")
        }
        print("--------------")
    }
    
}
