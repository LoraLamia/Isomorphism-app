import Foundation

class AlgorithmInvariantInducingFunctions {
    
    let graphOne: Graph
    let graphTwo: Graph
    var isomorphic: Bool = true
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
    }
    
    
    func getPartitions() {
        var values1X1: [Int] = []
        var values2X1: [Int] = []
        
        //usporedi X[0]
        if(graphOne.X[0][0].count != graphTwo.X[0][0].count) {
            self.isomorphic = false
            return
        }
        
        graphOne.X1()
        graphTwo.X1()
        
        //usporedi X[1]
        
        let len1 = graphOne.X[1].count
        let len2 = graphTwo.X[1].count
        
        if(len1 != len2) {
            self.isomorphic = false
            return
        }
        
        var i = -1
        for arr in graphOne.X[1] {
            i += 1
            if(arr.count != graphTwo.X[1][i].count) {
                self.isomorphic = false
                return
            }
            
            
            for (degree, vertices) in graphOne.dictX1 {
                if(arr.elementsEqual(vertices)) {
                    values1X1.append(degree)
                }
            }
        }
        
        for arr in graphTwo.X[1] {
            
            
            for (degree, vertices) in graphTwo.dictX1 {
                if(arr.elementsEqual(vertices)) {
                    values2X1.append(degree)
                }
            }
        }
        
        if(!values1X1.elementsEqual(values2X1)) {
            self.isomorphic = false
            return
        }
        
        graphOne.X2()
        graphTwo.X2()
        
        //usporedi X[2]
        
        if(graphOne.X[2].count != graphTwo.X[2].count) {
            self.isomorphic = false
            return
        }
        
        var values1X2: [[Int]] = []
        var values2X2: [[Int]] = []
        
        i = -1
        for arr in graphOne.X[2] {
            i += 1
            if(arr.count != graphTwo.X[2][i].count) {
                isomorphic = false
                return
            }
            
            
            for (adjArr, vertices) in graphOne.dictX2 {
                if(arr.elementsEqual(vertices)) {
                    values1X2.append(adjArr)
                }
            }
        }
        
        for arr in graphTwo.X[2] {
            
            
            for (adjArr, vertices) in graphTwo.dictX2 {
                if(arr.elementsEqual(vertices)) {
                    values2X2.append(adjArr)
                }
            }
        }
        
        var j = -1
        for arr in values1X2 {
            j += 1
            if(!arr.elementsEqual(values2X2[j])) {
                self.isomorphic = false
                return
            }
        }
    }
    
    func areIsomorphic() -> Bool {
        getPartitions()
        
        if(!self.isomorphic) {
            return false
        }
        
        return backtrack(vertexIndex: 0, mapping: [:])      //vertexIndex = vertexId
    }
    
    private func backtrack(vertexIndex: Int, mapping: [Int: Int]) -> Bool {
        if vertexIndex == graphOne.vertices.count {
            return true
        }
        
        let vertexOne = graphOne.vertices[vertexIndex]
        
        for vertexTwo in graphTwo.vertices {
            if isMappingGood(vertexOne: vertexOne, vertexTwo: vertexTwo, currentMapping: mapping) {
                var temp = mapping
                temp[vertexOne.id] = vertexTwo.id
                
                if backtrack(vertexIndex: vertexIndex + 1, mapping: temp) {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func isMappingGood(vertexOne: Vertex, vertexTwo: Vertex, currentMapping: [Int: Int]) -> Bool {
        for edge in graphOne.edges {
            if edge.from.id == vertexOne.id || edge.to.id == vertexOne.id {
                let mappedVertexId = (edge.from.id == vertexOne.id) ? edge.to.id : edge.from.id
                if let mappedTo = currentMapping[mappedVertexId] {
                    if !graphTwo.edges.contains(where: { ($0.from.id == vertexTwo.id || $0.to.id == vertexTwo.id) && ($0.from.id == mappedTo || $0.to.id == mappedTo) }) {
                        return false
                    }
                }
            }
        }
        return true
    }
}
