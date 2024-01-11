import Foundation

class AlgorithmCertificates {
    
    var graphOne: Graph
    var graphTwo: Graph
    var isomorphic: Bool = true
    var Y: [Vertex: [String]] = [:]
    var X: [Vertex: [String]] = [:]
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
    }
    
    func calculateCertificates() -> (String, String) {
        var certs = ("", "")
        for var vertex in graphOne.vertices {
            vertex.mark[vertex.id] = "01"
        }
        while(graphOne.vertices.count > 2) {
            for vertex in graphOne.vertices {
                if(graphOne.D1(vertex: vertex) == 1) {
                    continue
                }
                //tu sad idu koraci a,b,c algoritma
                
            }
        }
        var conc: [String] = []
        if(graphOne.vertices.count == 1) {
            certs.0 = graphOne.vertices[0].mark[graphOne.vertices[0].id] ?? "fail"
        } else if(graphOne.vertices.count == 2) {
            conc.append(graphOne.vertices[0].mark[graphOne.vertices[0].id] ?? "fail")
            conc.append(graphTwo.vertices[0].mark[graphTwo.vertices[0].id] ?? "fail")
            conc.sort()
            certs.0 = conc[0] + conc[1]
        }
        
        return certs
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
