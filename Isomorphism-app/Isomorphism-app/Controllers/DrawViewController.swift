import UIKit
import PureLayout

class DrawViewController: UIViewController {
    var graphCanvasView: GraphCanvasView!
    var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        graphCanvasView = GraphCanvasView()
        view.addSubview(graphCanvasView)
        
        view.backgroundColor = UIColor.white
        checkButton = UIButton()
        checkButton.setTitle("Are isomorphic?", for: .normal)
        checkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        checkButton.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        checkButton.tintColor = UIColor.white
        checkButton.layer.cornerRadius = 10
        checkButton.layer.shadowColor = UIColor.black.cgColor
        checkButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        checkButton.layer.shadowRadius = 5
        checkButton.layer.shadowOpacity = 0.5
        checkButton.layer.masksToBounds = false
        view.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkIsomorphism), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
    }
    
    func setupConstraints() {
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(.top, to: .bottom, of: graphCanvasView)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
    
    @objc func checkIsomorphism() {
        var alg: GraphIsomorphismAlgorithm?
        var message: String?
        
        if !graphCanvasView.graphOne.isTree() && !graphCanvasView.graphTwo.isTree() {
            
            alg = AlgorithmCertificatesGraphs(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
            
            let startTime = Date()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let isomorphic = alg?.areIsomorphic() ?? false
                
                let endTime = Date()
                let timeInterval = endTime.timeIntervalSince(startTime)
                
                message = isomorphic ? "Graphs are isomorphic!" : "Graphs are NOT isomorphic!"
                message = "\(message!)\nDetermination time: \(String(format: "%.5f", timeInterval)) seconds"
                
                DispatchQueue.main.async {
                    self.presentResultAlert(message: message)
                    self.graphCanvasView.resetGraphs()
                }
            }
        } else if graphCanvasView.graphOne.isTree() && graphCanvasView.graphTwo.isTree(){
            alg = AlgorithmCertificatesTrees(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
            
            let startTime = Date()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let isomorphic = alg?.areIsomorphic() ?? false
                
                let endTime = Date()
                let timeInterval = endTime.timeIntervalSince(startTime)
                
                message = isomorphic ? "Graphs are isomorphic!" : "Graphs are NOT isomorphic!"
                message = "\(message!)\nDetermination time: \(String(format: "%.5f", timeInterval)) seconds"
                
                DispatchQueue.main.async {
                    self.presentResultAlert(message: message)
                    self.graphCanvasView.resetGraphs()
                }
            }
        } else {
            message = "Graphs are NOT isomorphic because one is a Tree and other isn't!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
                self.graphCanvasView.resetGraphs()
            }
        }
    }
    
    func presentResultAlert(message: String?) {
        guard let message = message else { return }
        
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        
        let lines = message.components(separatedBy: "\n")
        
        let attributedMessage = NSMutableAttributedString()

        if let firstLine = lines.first {
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            
            attributedMessage.append(NSAttributedString(string: firstLine, attributes: boldAttributes))
            
            if lines.count > 1 {
                attributedMessage.append(NSAttributedString(string: "\n"))
            }
        }
        
        if lines.count > 1 {
            let regularAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18)
            ]
            attributedMessage.append(NSAttributedString(string: lines[1], attributes: regularAttributes))
        }

        alert.setValue(attributedMessage, forKey: "attributedMessage")

        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        alert.view.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)

        self.present(alert, animated: true, completion: nil)
    }
    
}


