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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        matrixSizeFieldOne = createMatrixSizeField(placeholder: "Enter size for graph 1")
        matrixSizeFieldTwo = createMatrixSizeField(placeholder: "Enter size for graph 2")
        
        scrollView.addSubview(matrixSizeFieldOne)
        scrollView.addSubview(matrixSizeFieldTwo)
        
        matrixSizeFieldOne.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 50)
        matrixSizeFieldOne.autoAlignAxis(toSuperviewAxis: .vertical)
        
        matrixSizeFieldTwo.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldOne, withOffset: 20)
        matrixSizeFieldTwo.autoAlignAxis(toSuperviewAxis: .vertical)
        
        generateButton = UIButton()
        generateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        generateButton.backgroundColor = UIColor.systemBlue
        generateButton.setTitleColor(.white, for: .normal)
        generateButton.layer.cornerRadius = 10
        generateButton.setTitle("Generate matrix fields", for: .normal)
        generateButton.layer.shadowColor = UIColor.black.cgColor
        generateButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        generateButton.layer.shadowRadius = 5
        generateButton.layer.shadowOpacity = 0.5
        generateButton.layer.masksToBounds = false
        generateButton.addTarget(self, action: #selector(generateMatrixInputFields), for: .touchUpInside)
        scrollView.addSubview(generateButton)
        
        generateButton.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldTwo, withOffset: 30)
        generateButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        generateButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        generateButton.autoSetDimension(.height, toSize: 50)
    }
    
    private func createMatrixSizeField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.keyboardType = .numberPad
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
            let message = "Adjacency matrices must have equal dimensions!"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let attributedMessage = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
                ]
            )
            alert.setValue(attributedMessage, forKey: "attributedMessage")
            
            let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.resetViewController()
            }
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        if (sizeOne > 8 || sizeTwo > 8) {
            let message = "This in an app for graphs with less than 9 vertices!"
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            
            let attributedMessage = NSMutableAttributedString(
                string: message,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
                ]
            )
            alert.setValue(attributedMessage, forKey: "attributedMessage")
            
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
        processButton.backgroundColor = UIColor.systemBlue
        processButton.setTitleColor(.white, for: .normal)
        processButton.layer.cornerRadius = 10
        processButton.setTitle("Are isomorphic?", for: .normal)
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
        
        var previousTextField: UITextField?
        
        for i in 0..<size {
            for j in 0..<size {
                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.keyboardType = .numberPad
                textField.tag = tag + (i * size) + j
                matrixView.addSubview(textField)
                
                textField.autoSetDimensions(to: CGSize(width: 40, height: 40))
                
                if j == 0 { //first column
                    textField.autoPinEdge(toSuperviewEdge: .leading)
                } else {
                    textField.autoPinEdge(.leading, to: .trailing, of: previousTextField!)
                }
                
                if i == 0 { //first row
                    textField.autoPinEdge(toSuperviewEdge: .top)
                } else {
                    //align textField to the one above it
                    if let aboveTextField = matrixView.viewWithTag(textField.tag - size) as? UITextField {
                        textField.autoPinEdge(.top, to: .bottom, of: aboveTextField)
                    }
                }
                
                previousTextField = textField
                
                if j == size - 1 { //last column
                    textField.autoPinEdge(toSuperviewEdge: .trailing)
                }
                
                if i == size - 1 { //last row
                    textField.autoPinEdge(toSuperviewEdge: .bottom)
                }
            }
            previousTextField = nil
        }
        return matrixView
    }
    
    private func resetViewController() {
        matrixSizeFieldOne.text = ""
        matrixSizeFieldTwo.text = ""
        inputMatrixViewOne?.removeFromSuperview()
        inputMatrixViewTwo?.removeFromSuperview()
        
//        inputMatrixViewOne = createMatrixInputFields(size: 0, tag: 100)
//        inputMatrixViewTwo = createMatrixInputFields(size: 0, tag: 200)
        
        graphOne = Graph()
        graphTwo = Graph()
        
        generateButton?.isHidden = false
        processButton?.isHidden = true
        
        self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 20)

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
        var message: String?
        
        if !graphOne.isTree() || !graphTwo.isTree() {
            message = "Both graphs need to be trees!"
            DispatchQueue.main.async {
                self.presentResultAlert(message: message)
                self.resetViewController()
            }
        } else {
            alg = AlgorithmCertificatesTrees(graphOne: graphOne, graphTwo: graphTwo)
            
            let startTime = Date()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let isomorphic = alg?.areIsomorphic() ?? false
                
                let endTime = Date()
                let timeInterval = endTime.timeIntervalSince(startTime)
                
                message = isomorphic ? "Graphs are isomorphic!" : "Graphs are NOT isomorphic!"
                message = "\(message!)\nDetermination time: \(String(format: "%.5f", timeInterval)) seconds"
                
                DispatchQueue.main.async {
                    self.presentResultAlert(message: message)
                    self.resetViewController()
                }
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

        self.present(alert, animated: true, completion: nil)
    }
    
    func parseMatrix(from matrixView: UIView, size: Int, startingTag: Int) -> [[Int]] {
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
        for i in 0..<size {
            for j in 0..<size {
                let tag = (i * size) + j + startingTag
                if let textField = matrixView.viewWithTag(tag) as? UITextField,
                   let text = textField.text,
                   let value = Int(text) {
                    matrix[i][j] = value
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
