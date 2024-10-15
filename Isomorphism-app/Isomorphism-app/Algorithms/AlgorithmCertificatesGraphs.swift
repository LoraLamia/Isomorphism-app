import Foundation

class AlgorithmCertificatesGraphs: GraphIsomorphismAlgorithm {
    
    var graphOne: Graph
    var graphTwo: Graph
    var isomorphic: Bool = true
    //    var B1: [[Vertex]]
    //    var B2: [[Vertex]]
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
        
    }
    
    func areIsomorphic() -> Bool {
        var A = initializePartition(for: graphOne)
        var THIS = refine(G: graphOne, A: A)
        return true
    }
    
    
    func initializePartition(for graph: Graph) -> [[Vertex]] {
        // Kreiramo praznu listu listi (particiju)
        var partition: [[Vertex]] = []
        
        // Svi vrhovi grafa idu u jedan blok
        var block = [Vertex]() // Prazan blok za vrhove
        
        // Dodajemo svaki vrh iz grafa u blok
        for i in 0..<graph.vertices.count {
            let vertex = graph.vertices[i]
            block.append(vertex)
        }
        
        // Dodajemo blok s vrhovima u particiju
        partition.append(block)
        
        // Vraćamo particiju koja sadrži jedan blok sa svim vrhovima
        return partition
    }
    
    func refine(G: Graph, A: [[Vertex]]) {
        var B = A  // Postavljamo B jednako A
        var S = [[Vertex]]()  // Inicijaliziramo S kao listu blokova iz B
        var first = true
        
        // Kopiramo blokove iz B u S
        for block in B {
            S.append(block)
        }
        
        // Inicijaliziramo T kao prazan blok
        var T: [Vertex]
        
        // Dok lista S nije prazna
        while !S.isEmpty {
            // Uzimamo zadnji blok iz S i uklanjamo ga iz S
            T = S.removeLast()
            
            // Iteriramo kroz svaki blok B[i] iz B
            for (i, block) in B.enumerated() {
                // Stvaramo L kao listu praznih blokova (jedan blok za svaki stupanj h)
                var L = Array(repeating: [Vertex](), count: G.vertices.count)
                
                // Korak 6: Dijelimo vrhove B[i] na temelju D_T(v)
                for vertex in block {
                    // Računamo D_T(v), tj. broj susjeda vrha vertex u bloku T
                    let degreeInT = G.DT(of: vertex, in: T)
                    
                    // Stavimo vrh u odgovarajući blok L[degreeInT]
                    L[degreeInT].append(vertex)
                }
                for i in L.indices {
                    print("\(L[i]) ")
                }
                // Pronađi sve neprazne blokove u L
                let nonEmptyBlocks = L.filter { !$0.isEmpty }
                
                // Ako postoji više od jednog nepraznog bloka u L
                if nonEmptyBlocks.count > 1 {
                    // Korak 8: Zamijenimo blok B[i] s prvim nepraznim blokom
                    B[i] = nonEmptyBlocks[0]
                    if first {
                        S.insert(nonEmptyBlocks[0], at: 0)
                    } else {
                        S.append(nonEmptyBlocks[0])
                    }
                    
                    // Korak 9: Dodajemo ostale neprazne blokove u B i S ako nisu već dodani
                    var j = i
                    for h in 1..<nonEmptyBlocks.count {
                        j += 1
                        print("h: \(h)")
                        // Provjeri da li već postoji blok u B prije dodavanja
                        if !B.contains(where: { $0 == nonEmptyBlocks[h] }) {
                            B.insert(nonEmptyBlocks[h], at: j)
                        }
                        
                        // Provjeri da li već postoji blok u S prije dodavanja
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
                    
            // Ispisujemo trenutnu verziju particije B nakon svake iteracije
            print("Trenutna particija B: ")
            for (index, block) in B.enumerated() {
                let blockIds = block.map { $0.id }  // Pretvaramo vrhove u njihove ID-eve za jednostavniji ispis
                print("Blok \(index): \(blockIds)")
            }
            print("--------------")
            print("Trenutna particija S: ")
            for (index, block) in S.enumerated() {
                let blockIds = block.map { $0.id }  // Pretvaramo vrhove u njihove ID-eve za jednostavniji ispis
                print("Blok \(index): \(blockIds)")
            }
            print("--------------")
            // Provjera: Ako je S prazna ili nema više promjena, prekini petlju
            if S.isEmpty {
                break
            }
        }
        
        // Konačni ispis ekvidistantne particije B
        print("Konačna ekvidistantna particija B:")
        for (index, block) in B.enumerated() {
            let blockIds = block.map { $0.id }  // Pretvaramo vrhove u njihove ID-eve za jednostavniji ispis
            print("Blok \(index): \(blockIds)")
        }
        print("--------------")
        print("Konačna ekvidistantna particija S:")
        for (index, block) in S.enumerated() {
            let blockIds = block.map { $0.id }  // Pretvaramo vrhove u njihove ID-eve za jednostavniji ispis
            print("Blok \(index): \(blockIds)")
        }
        print("--------------")
    }
    
}
