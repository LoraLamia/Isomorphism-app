//
//  GraphCanvasView.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import Foundation
import CoreGraphics
import UIKit
import PureLayout

class GraphCanvasView: UIView {
    var dividerView: UIView!
    var graph = Graph()
    private var tempEdge: Edge?
    private var startingVertex: Vertex?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCanvas()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCanvas()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        for edge in graph.edges {
            drawEdge(edge, in: context)
        }

        for vertex in graph.vertices {
            drawVertex(vertex, in: context)
        }
        
        if let tempEdge = tempEdge {
            drawEdge(tempEdge, in: context)
        }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        graph.addVertex(position: location)
        setNeedsDisplay() // Osvježava prikaz
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self)
        guard gesture.state == .began else { return }
        startingVertex = vertexNearPoint(location)
    }

    // Obrada potezanja za crtanje bridova
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        switch gesture.state {
        case .began:
            if startingVertex == nil {
                startingVertex = vertexNearPoint(location)
            }
        case .changed:
            guard let startVertex = startingVertex else { return }
            tempEdge = Edge(from: startVertex, to: Vertex(id: -1, position: location)) // Privremeni brid
            setNeedsDisplay()
        case .ended:
            if let startVertex = startingVertex, let endVertex = vertexNearPoint(location), startVertex.id != endVertex.id {
                graph.addEdge(from: startVertex, to: endVertex)
                tempEdge = nil
            }
            startingVertex = nil
            setNeedsDisplay()
        default:
            tempEdge = nil
            break
        }
    }

    func drawVertex(_ vertex: Vertex, in context: CGContext) {
        let radius: CGFloat = 10
        let circleRect = CGRect(x: vertex.position.x - radius, y: vertex.position.y - radius, width: radius * 2, height: radius * 2)
        context.addEllipse(in: circleRect)
        context.setFillColor(UIColor.blue.cgColor)
        context.fillPath()
    }

    func drawEdge(_ edge: Edge, in context: CGContext) {
        context.beginPath()
        context.move(to: edge.from.position)
        context.addLine(to: edge.to.position)
        context.setStrokeColor(UIColor.black.cgColor)
        context.strokePath()
    }

    
    private func vertexNearPoint(_ point: CGPoint) -> Vertex? {
        let touchRadius: CGFloat = 20.0
        return graph.vertices.first { vertex in
            return (vertex.position - point).magnitude <= touchRadius
        }
    }
    
    private func setupCanvas() {
        self.backgroundColor = UIColor.white
        
        setupDivider()
        setupGestureRecognizers()
    }
    
    private func setupDivider() {
        dividerView = UIView.newAutoLayout()
        dividerView.backgroundColor = UIColor.lightGray
        addSubview(dividerView)
        
        dividerView.autoSetDimension(.height, toSize: 10)
        dividerView.autoPinEdge(toSuperviewEdge: .left)
        dividerView.autoPinEdge(toSuperviewEdge: .right)
        dividerView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }
}

extension CGPoint {
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    var magnitude: CGFloat {
        return sqrt(x*x + y*y)
    }
}
