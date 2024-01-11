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
        return ("", "")
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
