import Foundation

struct AlgorithmInvariantInducingFunctions {
    
    let graphOne: Graph
    let graphTwo: Graph
    
    func checkForIsomorphism() -> Bool {
        
        getPartitions()
        
        return false
    }
    
    
    func getPartitions() -> Int {
        
        var X0G1: [[Vertex]] = []
        var X0G2: [[Vertex]] = []
        
        var X1G1: [[Vertex]] = []
        var X1G2: [[Vertex]] = []
        
        
        
        var X2G1Dictionary: [Int: [Vertex]] = [:]
        var X2G2Dictionary: [Int: [Vertex]] = [:]
        
        var X2G1: [[Vertex]] = []
        var X2G2: [[Vertex]] = []
        
        
        
        
        return 1
    }
    
    
    static func D1Full() -> [[Vertex]] {
        return []
    }
    
    static func D1() -> Int {
        return 0
    }
    
    static func D2Full() -> [[Vertex]] {
        return []
    }
    
    static func D2() -> [Int] {
        return []
    }
    
    
    
}
