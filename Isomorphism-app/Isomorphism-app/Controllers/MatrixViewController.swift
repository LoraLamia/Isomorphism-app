import UIKit
import PureLayout

class MatrixViewController: UIViewController, UITextFieldDelegate {
    
    var matrixSizeFieldOne: UITextField!
    var matrixSizeFieldTwo: UITextField!
    var inputMatrixViewOne: UIView!
    var inputMatrixViewTwo: UIView!
    var generateButton: UIButton!
    var processButton: UIButton!
    var scrollView: UIScrollView!
    var graphOne: Graph!
    var graphTwo: Graph!
    var activityIndicator: UIActivityIndicatorView!
    var dimmingOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        scrollViewSetUp()
        setupMatrixSizeFields()
    }
    
    private func scrollViewSetUp() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupMatrixSizeFields() {
        matrixSizeFieldOne = createMatrixSizeField(placeholder: "Unesi dimenzije za graf 1")
        matrixSizeFieldTwo = createMatrixSizeField(placeholder: "Unesi dimenzije za graf 2")
        
        scrollView.addSubview(matrixSizeFieldOne)
        scrollView.addSubview(matrixSizeFieldTwo)
        
        matrixSizeFieldOne.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 50)
        matrixSizeFieldOne.autoAlignAxis(toSuperviewAxis: .vertical)
        
        matrixSizeFieldTwo.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldOne, withOffset: 20)
        matrixSizeFieldTwo.autoAlignAxis(toSuperviewAxis: .vertical)
        
        generateButton = UIButton()
        generateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        generateButton.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        generateButton.setTitleColor(.white, for: .normal)
        generateButton.layer.cornerRadius = 10
        generateButton.setTitle("Generiraj matrice", for: .normal)
        generateButton.layer.shadowColor = UIColor.black.cgColor
        generateButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        generateButton.layer.shadowRadius = 5
        generateButton.layer.shadowOpacity = 0.5
        generateButton.layer.masksToBounds = false
        generateButton.addTarget(self, action: #selector(generateMatrixInputFields), for: .touchUpInside)
        scrollView.addSubview(generateButton)
        
        dimmingOverlay = UIView()
        dimmingOverlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingOverlay.isHidden = true
        view.addSubview(dimmingOverlay)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        generateButton.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldTwo, withOffset: 30)
        generateButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        generateButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        generateButton.autoSetDimension(.height, toSize: 50)
        
        dimmingOverlay.autoPinEdgesToSuperviewEdges()
        
        activityIndicator.autoCenterInSuperview()
    }
    
    private func createMatrixSizeField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = placeholder
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1.0)
        textField.layer.cornerRadius = 18
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8).cgColor
        textField.font = UIFont.systemFont(ofSize: 18)
        
        textField.autoSetDimension(.height, toSize: 40)
        textField.autoSetDimension(.width, toSize: 220)

        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        textField.layer.shadowOpacity = 0.3
        textField.layer.masksToBounds = false
        
        return textField
    }
    
    @objc func generateMatrixInputFields() {
        guard let sizeOneText = matrixSizeFieldOne.text,
              let sizeOne = Int(sizeOneText),
              let sizeTwoText = matrixSizeFieldTwo.text,
              let sizeTwo = Int(sizeTwoText) else {
            return
        }
        
        if (sizeOne != sizeTwo) {
            let message = "Matrice susjedstva moraju imati jednake dimenzije!"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let attributedMessage = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
                ]
            )
            alert.setValue(attributedMessage, forKey: "attributedMessage")
            alert.view.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.resetViewController()
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        if (sizeOne > 8 || sizeTwo > 8) {
            let message = "Ovo je aplikacija za grafove sa maksimalno 8 vrhova!"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let attributedMessage = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
                ]
            )
            alert.setValue(attributedMessage, forKey: "attributedMessage")
            alert.view.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.resetViewController()
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        generateButton.isHidden = true
        
        inputMatrixViewOne = createMatrixInputFields(size: sizeOne, tag: 100)
        inputMatrixViewTwo = createMatrixInputFields(size: sizeTwo, tag: 200)
        
        scrollView.addSubview(inputMatrixViewOne)
        scrollView.addSubview(inputMatrixViewTwo)
        
        inputMatrixViewOne.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldTwo, withOffset: 20)
        inputMatrixViewOne.autoAlignAxis(toSuperviewAxis: .vertical)
        inputMatrixViewOne.autoSetDimensions(to: CGSize(width: CGFloat(sizeOne * 40), height: CGFloat(sizeOne * 40)))
        
        inputMatrixViewTwo.autoPinEdge(.top, to: .bottom, of: inputMatrixViewOne, withOffset: 20)
        inputMatrixViewTwo.autoAlignAxis(toSuperviewAxis: .vertical)
        inputMatrixViewTwo.autoSetDimensions(to: CGSize(width: CGFloat(sizeTwo * 40), height: CGFloat(sizeTwo * 40)))
        
        processButton = UIButton()
        var bottomOffSet: CGFloat? = nil
        if (sizeOne == 8) {
            bottomOffSet = CGFloat(1180)
        } else if (sizeOne == 7) {
            bottomOffSet = CGFloat(1100)
        } else if (sizeOne == 6) {
            bottomOffSet = CGFloat(1020)
        } else if (sizeOne == 5) {
            bottomOffSet = CGFloat(940)
        } else if (sizeOne == 4) {
            bottomOffSet = CGFloat(860)
        } else if (sizeOne == 3) {
            bottomOffSet = CGFloat(780)
        } else {
            bottomOffSet = CGFloat(720)
        }
        let contentHeight = processButton.frame.maxY + bottomOffSet!
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
        
        processButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        processButton.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        processButton.setTitleColor(.white, for: .normal)
        processButton.layer.cornerRadius = 10
        processButton.setTitle("Provjeri izomorfnost", for: .normal)
        processButton.layer.shadowColor = UIColor.black.cgColor
        processButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        processButton.layer.shadowRadius = 5
        processButton.layer.shadowOpacity = 0.5
        processButton.layer.masksToBounds = false
        processButton.addTarget(self, action: #selector(processInputMatrices), for: .touchUpInside)
        scrollView.addSubview(processButton)
        
        processButton.autoPinEdge(.top, to: .bottom, of: inputMatrixViewTwo, withOffset: 20)
        processButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        processButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        processButton.autoSetDimension(.height, toSize: 50)
        
    }
    
    private func createMatrixInputFields(size: Int, tag: Int) -> UIView {
        let matrixView = UIView()
        
        var previousButton: MatrixUIButton?
        
        for i in 0..<size {
            for j in 0..<size {
                let button = MatrixUIButton()
                button.tag = tag + (i * size) + j
                matrixView.addSubview(button)
                
                button.autoSetDimensions(to: CGSize(width: 40, height: 40))
                
                if j == 0 { // Prva kolona
                    button.autoPinEdge(toSuperviewEdge: .leading)
                } else {
                    button.autoPinEdge(.leading, to: .trailing, of: previousButton!)
                }
                
                if i == 0 { // Prvi red
                    button.autoPinEdge(toSuperviewEdge: .top)
                } else {
                    // Poravnanje s dugmetom iznad
                    if let aboveButton = matrixView.viewWithTag(button.tag - size) as? MatrixUIButton {
                        button.autoPinEdge(.top, to: .bottom, of: aboveButton)
                    }
                }
                
                previousButton = button
                
                if j == size - 1 { // Posljednja kolona
                    button.autoPinEdge(toSuperviewEdge: .trailing)
                }
                
                if i == size - 1 { // Posljednji red
                    button.autoPinEdge(toSuperviewEdge: .bottom)
                }
            }
            previousButton = nil
        }
        return matrixView
    }
    
    private func resetViewController() {
        matrixSizeFieldOne.text = ""
        matrixSizeFieldTwo.text = ""
        inputMatrixViewOne?.removeFromSuperview()
        inputMatrixViewTwo?.removeFromSuperview()
        
        graphOne = Graph()
        graphTwo = Graph()
        
        generateButton?.isHidden = false
        processButton?.isHidden = true

        self.view.layoutIfNeeded()
    }

    @objc func processInputMatrices() {
        guard let sizeOne = matrixSizeFieldOne.text.flatMap(Int.init),
              let sizeTwo = matrixSizeFieldTwo.text.flatMap(Int.init),
              inputMatrixViewOne.subviews.count == sizeOne * sizeOne,
              inputMatrixViewTwo.subviews.count == sizeTwo * sizeTwo else {
            return
        }
        
        let adjacencyMatrixOne = parseMatrix(from: inputMatrixViewOne, size: sizeOne, startingTag: 100)
        let adjacencyMatrixTwo = parseMatrix(from: inputMatrixViewTwo, size: sizeTwo, startingTag: 200)
        
        graphOne = createGraph(from: adjacencyMatrixOne)
        graphTwo = createGraph(from: adjacencyMatrixTwo)
        
        graphOne.cleanUpDoubleEdges()
        graphTwo.cleanUpDoubleEdges()
        
        var alg: GraphIsomorphismAlgorithm?
        
        if !graphOne.isTree() && !graphTwo.isTree() {
            
            alg = AlgorithmCertificatesGraphs(graphOne: graphOne, graphTwo: graphTwo)
            alertWindow(alg: alg)
            
        } else if graphOne.isTree() && graphTwo.isTree() {
            
            alg = AlgorithmCertificatesTrees(graphOne: graphOne, graphTwo: graphTwo)
            alertWindow(alg: alg)
            
        } else {
            let message = "Grafovi nisu izomorfni jer je jedan stablo, a drugi nije!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
                self.resetViewController()
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
            let isomorphic = alg?.areIsomorphic() ?? false
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            
            message = isomorphic ? "Grafovi su izomorfni!" : "Grafovi nisu izomorfni!"
            message = "\(message!)\nVrijeme izvođenja: \(String(format: "%.5f", timeInterval)) sekundi"
            
            DispatchQueue.main.async {
                self.dimmingOverlay.isHidden = true
                self.activityIndicator.stopAnimating()
                self.presentResultAlert(message: message)
                self.resetViewController()
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
    
    func parseMatrix(from matrixView: UIView, size: Int, startingTag: Int) -> [[Int]] {
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
        for i in 0..<size {
            for j in 0..<size {
                let tag = (i * size) + j + startingTag
                if let button = matrixView.viewWithTag(tag) as? MatrixUIButton {
                    matrix[i][j] = button.isSelected ? 1 : 0
                }
            }
        }
        return matrix
    }
    
    private func createGraph(from adjacencyMatrix: [[Int]]) -> Graph {
        let graph = Graph()
        let vertexCount = adjacencyMatrix.count
        
        for _ in 0..<vertexCount {
            graph.addVertex(position: CGPoint(x: 0, y: 0))
        }
        
        for i in 0..<vertexCount {
            for j in 0..<vertexCount {
                if adjacencyMatrix[i][j] == 1 && i != j { //check for edge and avoid self-loops
                    graph.addEdge(from: graph.vertices[i], to: graph.vertices[j])
                }
            }
        }
        
        return graph
    }
}
