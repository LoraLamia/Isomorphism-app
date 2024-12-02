import UIKit
import PureLayout

class DrawViewController: UIViewController {
    var graphCanvasView: GraphCanvasView!
    var checkButton: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    var dimmingOverlay: UIView!
    
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
        checkButton.setTitle("Provjeri izomorfnost", for: .normal)
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
        
        dimmingOverlay = UIView()
        dimmingOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingOverlay.isHidden = true
        view.addSubview(dimmingOverlay)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(.top, to: .bottom, of: graphCanvasView)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        dimmingOverlay.autoPinEdgesToSuperviewEdges()
        
        activityIndicator.autoCenterInSuperview()
    }
    
    @objc func checkIsomorphism() {
        if graphCanvasView.graphOne.vertices.isEmpty || graphCanvasView.graphTwo.vertices.isEmpty {
            let message = "Unesite oba grafa prije provjere izomorfnosti!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
            }
            return
        }
        if graphCanvasView.graphOne.vertices.count > 8 || graphCanvasView.graphTwo.vertices.count > 8 {
            let message = "Ovo je aplikacija za grafove sa maksimalno 8 vrhova!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
            }
            self.graphCanvasView.resetGraphs()
            return
        }
        
        if graphCanvasView.graphOne.vertices.count != graphCanvasView.graphTwo.vertices.count {
            let message = "Grafovi nisu izomorfni jer imaju različit broj vrhova!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
            }
            self.graphCanvasView.resetGraphs()
            return
        }
        
        var alg: GraphIsomorphismAlgorithm?
        
        if !graphCanvasView.graphOne.isTree() && !graphCanvasView.graphTwo.isTree() {
            
            alg = AlgorithmCertificatesGraphs(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
            alertWindow(alg: alg)
            
        } else if graphCanvasView.graphOne.isTree() && graphCanvasView.graphTwo.isTree(){
            
            alg = AlgorithmCertificatesTrees(graphOne: graphCanvasView.graphOne, graphTwo: graphCanvasView.graphTwo)
            alertWindow(alg: alg)
            
        } else {
            let message = "Grafovi nisu izomorfni jer je jedan stablo, a drugi nije!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
                self.graphCanvasView.resetGraphs()
            }
        }
    }
    
    private func alertWindow(alg: GraphIsomorphismAlgorithm?) {
        let startTime = Date()
        var message: String?
        
        DispatchQueue.main.async {
            self.dimmingOverlay.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let alg = alg
            else {
                print("No algorithm available")
                DispatchQueue.main.async {
                    self.dimmingOverlay.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            let isomorphic = alg.areIsomorphic()
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            
            var cert1: String = "N/A"
            var cert2: String = "N/A"
            
            if let treeAlg = alg as? AlgorithmCertificatesTrees {
                cert1 = treeAlg.cert1
                cert2 = treeAlg.cert2
            } else if let graphAlg = alg as? AlgorithmCertificatesGraphs {
                cert1 = String(graphAlg.cert1)
                cert2 = String(graphAlg.cert2)
            }
            
            
            message = isomorphic ? "Grafovi su izomorfni!" : "Grafovi nisu izomorfni!"
            message = """
                    \(message!)
                    Vrijeme izvođenja: \(String(format: "%.5f", timeInterval)) sekundi
                    Certifikat grafa 1: \(cert1)
                    Certifikat grafa 2: \(cert2)
                    """
            
            DispatchQueue.main.async {
                self.dimmingOverlay.isHidden = true
                self.activityIndicator.stopAnimating()
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
                for line in lines.dropFirst() {
                    let regularAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 18)
                    ]
                    attributedMessage.append(NSAttributedString(string: line + "\n", attributes: regularAttributes))
                }
            }
        
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        alert.view.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        
        DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
    }
    
}


