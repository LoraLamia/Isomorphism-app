import Foundation

class AlgorithmCertificates {
    
    var graphOne: Graph
    var graphTwo: Graph
    var isomorphic: Bool = true
//    var Y: [Vertex: [String]] = [:]
//    var X: [Vertex: [String]] = [:]
    
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
            for vertex in graph.vertices {
                if(graph.D1(vertex: vertex) == 1) {
                    continue
                }
                //tu sad idu koraci a,b,c algoritma
                
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
        if(graphOne.isTree()) {
            print("Prvi graf je stablo!")
        } else {
            print("Prvi graf NIJE stablo!")
        }
        
        if(graphTwo.isTree()) {
            print("Drugi graf je stablo!")
        } else {
            print("Drugi graf NIJE stablo!")
        }
        
        let cert = calculateCertificates()
        if(cert.0 == cert.1) {
            return true
        } else {
            return false
        }
    }
}
