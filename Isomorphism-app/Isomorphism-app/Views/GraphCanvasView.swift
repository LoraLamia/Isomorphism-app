import Foundation
import CoreGraphics
import UIKit
import PureLayout

class GraphCanvasView: UIView {
    var dividerView: UIView!
    var graphOne = Graph()
    var graphTwo = Graph()
    private var tempEdge: Edge?
    private var startingVertex: Vertex?
    private var editingGraphOne = true

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
        
        print("DEBUGGGG - Draw")
        
        for edge in graphOne.edges {
            drawEdge(edge, in: context)
        }
        
        for vertex in graphOne.vertices {
            drawVertex(vertex, in: context)
        }
        
        for edge in graphTwo.edges {
            drawEdge(edge, in: context)
        }
        
        for vertex in graphTwo.vertices {
            drawVertex(vertex, in: context)
        }
        
        if let tempEdge = tempEdge {
            drawEdge(tempEdge, in: context)
        }
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        print("DEBUGGGG - TAP")
        let location = gesture.location(in: self)
        // Odlučite koji graf treba ažurirati ovisno o lokaciji tapkanja
        if location.y < self.bounds.midY {
            editingGraphOne = true
            graphOne.addVertex(position: location)
        } else {
            editingGraphOne = false
            graphTwo.addVertex(position: location)
        }
        setNeedsDisplay() // Osvježava prikaz
    }

    // Obrada potezanja za crtanje bridova
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: self)
        print("DEBUGGGG - Pan locatioN: \(location)")
        switch gesture.state {
        case .began:
            // Provjeravamo postoji li već odabrani početni vrh
            if startingVertex == nil {
                startingVertex = vertexNearPoint(location)
            }
        case .changed:
            // Ako postoji početni vrh, stvaramo privremeni brid
            if let startVertex = startingVertex {
                tempEdge = Edge(from: startVertex, to: Vertex(id: -1, position: location))
                setNeedsDisplay()
            }
        case .ended:
            // Na kraju poteza, provjeravamo postoji li krajnji vrh blizu lokacije
            if let startVertex = startingVertex, let endVertex = vertexNearPoint(location), startVertex.id != endVertex.id {
                // Ovisno o tome koji se graf uređuje, dodajemo brid u odgovarajući graf
                if editingGraphOne {
                    graphOne.addEdge(from: startVertex, to: endVertex)
                } else {
                    graphTwo.addEdge(from: startVertex, to: endVertex)
                }
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
        let vertices = editingGraphOne ? graphOne.vertices : graphTwo.vertices
        
        return vertices.first { vertex in
            return (vertex.position - point).magnitude <= touchRadius
        }
    }
    
    private func setupCanvas() {
        self.backgroundColor = UIColor.white
        
        setupDivider()
        setupGestureRecognizers()
    }
    
    private func setupDivider() {
        dividerView = UIView()
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
