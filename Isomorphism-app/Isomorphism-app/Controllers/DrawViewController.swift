import UIKit
import PureLayout

class DrawViewController: UIViewController {
    var graphCanvasView: GraphCanvasView!
    var checkButton: UIButton!
    let popupView = PopUpView()
    
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
        checkButton.backgroundColor = UIColor.systemBlue
        checkButton.tintColor = UIColor.white
        checkButton.layer.cornerRadius = 10
        checkButton.layer.shadowColor = UIColor.black.cgColor
        checkButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        checkButton.layer.shadowRadius = 5
        checkButton.layer.shadowOpacity = 0.5
        checkButton.layer.masksToBounds = false
        view.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkIsomorphism), for: .touchUpInside)
        popupView.confirmButton.addTarget(self, action: #selector(selectAlgorithm), for: .touchUpInside)
        
        view.addSubview(popupView)
        popupView.isHidden = true
    }
    
    func setupConstraints() {
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(.top, to: .bottom, of: graphCanvasView)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        popupView.autoPinEdgesToSuperviewEdges()
    }
    
    @objc func checkIsomorphism() {
        popupView.isHidden = false
    }
    
    @objc func selectAlgorithm() {
        let selectionIndex = popupView.picker.selectedRow(inComponent: 0)
        let selection = popupView.choices[selectionIndex]
        
        var alg: GraphIsomorphismAlgorithm?
        var message: String?
        if(selection == "Invarijants algorithm") {
            alg = AlgorithmInvariantInducingFunctions(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
        } else if(selection == "Certificates algorithm") {
            if(!graphCanvasView.graphOne.isTree() || !graphCanvasView.graphTwo.isTree()) {
            } else {
                alg = AlgorithmCertificates(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
            }
        }
        
        if let alg = alg {
            message = alg.areIsomorphic() ? "Graphs are isomorphic!" : "Graphs are NOT isomorphic!"
        } else {
            message = "Both graphs need to be trees!"
        }
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let attributedMessage = NSMutableAttributedString(
            string: message ?? "",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
            ]
        )
        
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.graphCanvasView.resetGraphs()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        popupView.isHidden = true
    }
    
    
}


