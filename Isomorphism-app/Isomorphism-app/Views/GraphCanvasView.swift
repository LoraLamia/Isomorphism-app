import Foundation
import CoreGraphics
import UIKit
import PureLayout

class GraphCanvasView: UIView {
    var graphOne = Graph()
    var graphTwo = Graph()
    private var dividerView = UIView()
    private var tempEdge: Edge?
    private var startingVertex: Vertex?
    private var editingGraphOne = true
    private var drawHereLabelTop = UILabel()
    private var drawHereLabelBottom = UILabel()


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
        
        for edge in graphOne.edges {
            drawEdge(edge, in: context)
        }
        
        for edge in graphTwo.edges {
            drawEdge(edge, in: context)
        }
        
        for vertex in graphOne.vertices {
            drawVertex(vertex, in: context)
        }
        
        for vertex in graphTwo.vertices {
            drawVertex(vertex, in: context)
        }
        
        if let tempEdge = tempEdge {
            drawEdge(tempEdge, in: context)
        }
        
        drawHereLabelTop.isHidden = !graphOne.vertices.isEmpty
        drawHereLabelBottom.isHidden = !graphTwo.vertices.isEmpty
    }

    //obrada tap-a
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        //odluka koji graf treba azurirati ovisno o lokaciji tap-a
        if location.y < self.bounds.midY {
            editingGraphOne = true
            graphOne.addVertex(position: location)
        } else {
            editingGraphOne = false
            graphTwo.addVertex(position: location)
        }
        setNeedsDisplay() //reload
    }

    //obrada potezanja bridova (pan)
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let location = gesture.location(in: self)
        if location.y < self.bounds.midY {
            editingGraphOne = true
        } else {
            editingGraphOne = false
        }
        switch gesture.state {
        case .began:
            //postoji li odabrani pocetni vrh
            if startingVertex == nil {
                startingVertex = vertexNearPoint(location)
            }
        case .changed:
            //ako postoji pocetni vrh, stvaramo privremeni brid
            if let startVertex = startingVertex {
                tempEdge = Edge(from: startVertex, to: Vertex(id: -1, position: location))
                setNeedsDisplay()
            }
        case .ended:
            //provjera postoji li vrh blizu lokacije
            if let startVertex = startingVertex, let endVertex = vertexNearPoint(location), startVertex.id != endVertex.id {
                //dodavanje brida u onaj graf koji se ureduje
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
        context.setFillColor(UIColor(red: 60/255, green: 110/255, blue: 160/255, alpha: 1).cgColor)
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
        setupLabels()
        
        drawHereLabelTop.autoPinEdge(toSuperviewEdge: .top)
        drawHereLabelTop.autoPinEdge(toSuperviewEdge: .leading)
        drawHereLabelTop.autoPinEdge(toSuperviewEdge: .trailing)
        drawHereLabelTop.autoPinEdge(.bottom, to: .top, of: dividerView)
        
        drawHereLabelBottom.autoPinEdge(.top, to: .bottom, of: dividerView)
        drawHereLabelBottom.autoPinEdge(toSuperviewEdge: .leading)
        drawHereLabelBottom.autoPinEdge(toSuperviewEdge: .trailing)
        drawHereLabelBottom.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    private func setupDivider() {
        dividerView.backgroundColor = UIColor.lightGray
        addSubview(dividerView)
        
        dividerView.autoSetDimension(.height, toSize: 10)
        dividerView.autoPinEdge(toSuperviewEdge: .left)
        dividerView.autoPinEdge(toSuperviewEdge: .right)
        dividerView.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    private func setupLabels() {
        drawHereLabelTop.text = "Ovdje nacrtaj graf"
        drawHereLabelTop.textAlignment = .center
        drawHereLabelTop.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        drawHereLabelTop.font = UIFont.boldSystemFont(ofSize: 50)
        drawHereLabelTop.numberOfLines = 0
        addSubview(drawHereLabelTop)

        drawHereLabelBottom.text = "Ovdje nacrtaj graf"
        drawHereLabelBottom.textAlignment = .center
        drawHereLabelBottom.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        drawHereLabelBottom.font = UIFont.boldSystemFont(ofSize: 50)
        drawHereLabelBottom.numberOfLines = 0
        addSubview(drawHereLabelBottom)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    func resetGraphs() {
        graphOne = Graph()
        graphTwo = Graph()
        setNeedsDisplay() 
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
