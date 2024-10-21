import Foundation
import UIKit

class GraphBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let vertexColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8).cgColor
        let edgeColor = UIColor(red: 22/255, green: 93/255, blue: 190/255, alpha: 0.4).cgColor
        
        let vertexRadius: CGFloat = 5.0
        let numberOfVertices = 20
        var points: [CGPoint] = []
        
        for _ in 0..<numberOfVertices {
            let randomX = CGFloat.random(in: 0...rect.width)
            let randomY = CGFloat.random(in: 0...rect.height)
            let point = CGPoint(x: randomX, y: randomY)
            points.append(point)
            
            context.setFillColor(vertexColor)
            context.addEllipse(in: CGRect(x: randomX - vertexRadius, y: randomY - vertexRadius, width: vertexRadius * 2, height: vertexRadius * 2))
            context.fillPath()
        }
        
        context.setStrokeColor(edgeColor)
        context.setLineWidth(1.0)
        for _ in 0..<numberOfVertices {
            let start = points.randomElement()!
            let end = points.randomElement()!
            
            context.move(to: start)
            context.addLine(to: end)
            context.strokePath()
        }
    }
}


