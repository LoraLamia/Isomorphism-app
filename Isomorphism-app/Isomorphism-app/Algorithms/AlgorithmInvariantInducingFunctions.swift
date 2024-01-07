import Foundation

class AlgorithmInvariantInducingFunctions {
    
    let graphOne: Graph
    let graphTwo: Graph
    var isomorphic: Bool = true
    
    init(graphOne: Graph, graphTwo: Graph) {
        self.graphOne = graphOne
        self.graphTwo = graphTwo
    }
    
    func checkForIsomorphism() -> Bool {
        
       
        
        
        
        
        return false
    }
    
    
    func getPartitions() {
        var values1: [Int] = []
        var values2: [Int] = []
        
        //usporedi X[0]
        if(graphOne.X[0][0].count != graphTwo.X[0][0].count) {
            self.isomorphic = false
            return
        }
        
        graphOne.X1()
        graphTwo.X1()
        
        //usporedi X[0]
        
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
                isomorphic = false
                return
            }
            
            
            for (degree, vertices) in graphOne.dictX1 {
                if(arr.elementsEqual(vertices)) {
                    values1.append(degree)
                }
            }
        }
        
        for arr in graphTwo.X[1] {
            
            
            for (degree, vertices) in graphTwo.dictX1 {
                if(arr.elementsEqual(vertices)) {
                    values2.append(degree)
                }
            }
        }
        
        if(!values1.elementsEqual(values2)) {
            self.isomorphic = false
            return
        }
        
        if(!self.isomorphic) {
            print("NISU IZOMORFNI")
        } else {
            print("jeeeej proslo je!!!!")
        }
        
        graphOne.X2()
        graphTwo.X2()
        
        //usporedi X[2]
    }
}
