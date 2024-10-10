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
        return true
    }
    
    
}
