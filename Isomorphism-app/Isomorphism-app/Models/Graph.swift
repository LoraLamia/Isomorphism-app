//
//  Graph.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import Foundation

class Graph {
    var vertices: [Vertex] = []
    var edges: [Edge] = []
    
    func addVertex(position: CGPoint) {
        let newVertex = Vertex(id: vertices.count, position: position)
        vertices.append(newVertex)
    }
    
    func addEdge(from: Vertex, to: Vertex) {
        let newEdge = Edge(from: from, to: to)
        edges.append(newEdge)
    }
}