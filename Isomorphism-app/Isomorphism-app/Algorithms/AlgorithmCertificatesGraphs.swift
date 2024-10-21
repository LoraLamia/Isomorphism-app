import Foundation

class AlgorithmCertificatesGraphs: GraphIsomorphismAlgorithm {
    
    var graphOne: Graph
    var graphTwo: Graph
    var bestOrdering1: [[Vertex]]
    var bestExists = false
    var prviProlaz = true
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
        self.bestOrdering1 = []
    }
    
    func areIsomorphic() -> Bool {
        let v = cert(G: graphOne)
        print("Certifikat je: \(v)")
        if let decimal = binaryToDecimal(v) {
            print("Decimalni broj je: \(decimal)")
        } else {
            print("Neispravan binarni broj.")
        }
        return true
    }
    
    
    func initializePartition(for graph: Graph) -> [[Vertex]] {
        var partition: [[Vertex]] = []
        var block = [Vertex]()
        
//                block.append(graph.vertices[0])
//                var block2 = [Vertex]()
//                for i in 1..<graph.vertices.count {
//                    let vertex = graph.vertices[i]
//                    block2.append(vertex)
//                }
//                partition.append(block)
//                partition.append(block2)
        
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
        
        print("Pocetna particija S: \(S.map { $0.map { $0.id } })")
        
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
                    print("worse")
                    return .worse
                } else if x > y {
                    print("better")
                    return .better
                }
            }
        }
        print("equal")
        return .equal
    }
    
    func canon(G: Graph, P: [[Vertex]]) {
        print("Poziv funkcije canon s particijom P: \(P.map { block in block.map { $0.id } })")
        print("Trenutno stanje bestExists: \(bestExists)")
        let Q = refine(G: G, A: P)
        
        let l = Q.firstIndex(where: { $0.count > 1 }) ?? Q.count
        
        if bestExists == true {
            var pi1: [[Vertex]] = []
            for i in 0..<l {
                if Q[i].count == 1 {
                    pi1.append(Q[i])
                } else {
                    break
                }
            }
            print("Sadržaj najboljeg!: \(bestOrdering1.map { block in block.map { $0.id } })")
            print("Sadržaj Q: \(Q.map { block in block.map { $0.id } })")
            
            print ("Sada ide poziv 1 funkcije compare: ")
            print ("Duljina najboljeg: \(bestOrdering1.count)")
            print ("Duljina potencijalog: \(pi1.count)")
            
            print("Sadržaj pi1: \(pi1.map { block in block.map { $0.id } })")

            let Res = compare(G: G, μ: bestOrdering1, π: pi1, n: pi1.count)
            
            if Res == .worse {
                return
            }
        }
        if Q.count == G.vertices.count {
            print("duljina je jednaka + drugi poziv funkcije compare")
            if bestExists == false || compare(G: G, μ: bestOrdering1, π: Q, n: G.vertices.count) == .better {
                bestOrdering1 = Q
                bestExists = true
            }
            
        } else {
            
            print("poziva se dijeljenje blokova")
            
            let C = Q[l]
            let D = C
            
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
    
    
    func cert(G: Graph) -> String {
        let startPart = initializePartition(for: G)
        canon(G: G, P: startPart)
        
        var s = ""
        for j in 1..<G.vertices.count {
            for i in 0..<j {
                if(G.areAdjacent(bestOrdering1[i][0],bestOrdering1[j][0])) {
                    s.append("1")
                } else {
                    s.append("0")
                }
            }
        }
        
        return s
    }
    
    func binaryToDecimal(_ binary: String) -> Int? {
        var decimalValue = 0
        var exponent = 0

        for digit in binary.reversed() {
            if let bit = Int(String(digit)) {
                if bit == 0 || bit == 1 {
                    decimalValue += bit * Int(pow(2.0, Double(exponent)))
                    exponent += 1
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        
        return decimalValue
    }
    
    
    
}


enum ComparisonResult {
    case better
    case worse
    case equal
}


