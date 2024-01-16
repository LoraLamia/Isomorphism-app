import Foundation

class AlgorithmCertificates {
    
    var graphOne: Graph
    var graphTwo: Graph
    var isomorphic: Bool = true
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
    }
    
    func calculateCertificates() -> (String, String) {
        var certs = ("", "")
        certs.0 = calculateCertficate(graph: graphOne)
        print("Ovo je certifikat za prvi graf: \(certs.0)")
        certs.1 = calculateCertficate(graph: graphTwo)
        print("Ovo je certifikat za drugi graf: \(certs.1)")
        
        return certs
    }
    
    func calculateCertficate(graph: Graph) -> String {
        var cert = ""
        
        for vertex in graph.vertices {
            vertex.mark = "01"
        }
        
        while(graph.vertices.count > 2) {
            print(graph.vertices.count)
            for vertex in graph.vertices {
                if(graph.D1(vertex: vertex) == 1) {
                    continue
                }
                var Y: [String] = []
                for edge in graph.edges {
                    if(edge.from == vertex) {
                        if(graph.D1(vertex: edge.to) == 1) {
                            Y.append(edge.to.mark)
                        }
                    } else if(edge.to == vertex) {
                        if(graph.D1(vertex: edge.from) == 1) {
                            Y.append(edge.from.mark)
                        }
                    }
                }
                let vertexModified = String(vertex.mark.dropFirst().dropLast())
                Y.append(vertexModified)
                Y.sort()
                var concat = ""
                for str in Y {
                    concat += str
                }
                vertex.mark = "0" + concat + "1"
                for edge in graph.edges {
                    if(edge.from == vertex) {
                        if(graph.D1(vertex: edge.to) == 1) {
                            graph.removeVertex(vertex: edge.to)
                        }
                    } else if(edge.to == vertex) {
                        if(graph.D1(vertex: edge.from) == 1) {
                            graph.removeVertex(vertex: edge.from)
                        }
                    }
                }
            }
        }
        var conc: [String] = []
        if(graph.vertices.count == 1) {
            cert = graph.vertices[0].mark
        } else if(graph.vertices.count == 2) {
            conc.append(graph.vertices[0].mark)
            conc.append(graph.vertices[1].mark)
            conc.sort()
            cert = conc[0] + conc[1]
        }
        
        return cert
    }
    
    func areIsomorphic() -> Bool {
//        if(graphOne.isTree()) {
//            print("Prvi graf je stablo!")
//        } else {
//            print("Prvi graf NIJE stablo!")
//        }
//        
//        if(graphTwo.isTree()) {
//            print("Drugi graf je stablo!")
//        } else {
//            print("Drugi graf NIJE stablo!")
//        }
        
        let cert = calculateCertificates()
        if(cert.0 == cert.1) {
            return true
        } else {
            return false
        }
    }
}
