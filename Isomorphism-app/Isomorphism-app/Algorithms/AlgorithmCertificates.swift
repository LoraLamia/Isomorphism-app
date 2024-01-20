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
        certs.1 = calculateCertficate(graph: graphTwo)
        
        return certs
    }
    
    func calculateCertficate(graph: Graph) -> String {
        var cert = ""
        
        for vertex in graph.vertices {
            vertex.mark = "01"
        }
        
        while(graph.vertices.count > 2) {
            let graphCurrentState = graph.replicate()
            
            for vertex in graphCurrentState.vertices {
                if(graphCurrentState.D1(vertex: vertex) == 1) {
                    continue
                }
                var Y: [String] = []
                for edge in graphCurrentState.edges {
                    if(edge.from == vertex) {
                        if(graphCurrentState.D1(vertex: edge.to) == 1) {
                            Y.append(edge.to.mark)
                        }
                    } else if(edge.to == vertex) {
                        if(graphCurrentState.D1(vertex: edge.from) == 1) {
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
                for edge in graphCurrentState.edges {
                    if(edge.from == vertex) {
                        if(graphCurrentState.D1(vertex: edge.to) == 1) {
                            graph.removeVertex(vertex: edge.to)
                        }
                    } else if(edge.to == vertex) {
                        if(graphCurrentState.D1(vertex: edge.from) == 1) {
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
        
        let cert = calculateCertificates()
        if(cert.0 == cert.1) {
            return true
        } else {
            return false
        }
    }
}
