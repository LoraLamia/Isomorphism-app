import UIKit
import PureLayout

class MatrixViewController: UIViewController {
    
    var matrixSizeFieldOne: UITextField!
    var matrixSizeFieldTwo: UITextField!
    var inputMatrixViewOne: UIView!
    var inputMatrixViewTwo: UIView!
    var generateButton: UIButton!
    var processButton: UIButton!
    
    var graphOne: Graph!
    var graphTwo: Graph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMatrixSizeFields()
    }
    
    func setupMatrixSizeFields() {
        matrixSizeFieldOne = createMatrixSizeField(placeholder: "Enter size for graph 1")
        matrixSizeFieldTwo = createMatrixSizeField(placeholder: "Enter size for graph 2")
        
        view.addSubview(matrixSizeFieldOne)
        view.addSubview(matrixSizeFieldTwo)
        
        matrixSizeFieldOne.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        matrixSizeFieldOne.autoAlignAxis(toSuperviewAxis: .vertical)
        
        matrixSizeFieldTwo.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldOne, withOffset: 20)
        matrixSizeFieldTwo.autoAlignAxis(toSuperviewAxis: .vertical)
        
        // Add a button to generate matrix input fields
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
        view.addSubview(generateButton)
        
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
        
        generateButton.isHidden = true
        
        // Create and display matrix input fields based on entered sizes
        inputMatrixViewOne = createMatrixInputFields(size: sizeOne, tag: 100)
        inputMatrixViewTwo = createMatrixInputFields(size: sizeTwo, tag: 200)
        
        view.addSubview(inputMatrixViewOne)
        view.addSubview(inputMatrixViewTwo)
        
        // Setup constraints for matrix input views
        inputMatrixViewOne.autoPinEdge(.top, to: .bottom, of: matrixSizeFieldTwo, withOffset: 20)
        inputMatrixViewOne.autoAlignAxis(toSuperviewAxis: .vertical)
        inputMatrixViewOne.autoSetDimensions(to: CGSize(width: CGFloat(sizeOne * 40), height: CGFloat(sizeOne * 40)))
        
        inputMatrixViewTwo.autoPinEdge(.top, to: .bottom, of: inputMatrixViewOne, withOffset: 20)
        inputMatrixViewTwo.autoAlignAxis(toSuperviewAxis: .vertical)
        inputMatrixViewTwo.autoSetDimensions(to: CGSize(width: CGFloat(sizeTwo * 40), height: CGFloat(sizeTwo * 40)))
        
        // Add a button to process the matrices
        processButton = UIButton()
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
        view.addSubview(processButton)
        
        processButton.autoPinEdge(.top, to: .bottom, of: inputMatrixViewTwo, withOffset: 20)
        processButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        processButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        processButton.autoSetDimension(.height, toSize: 50)
    }
    
    func createMatrixInputFields(size: Int, tag: Int) -> UIView {
        let matrixView = UIView()
        
        var previousTextField: UITextField?
        
        // Create matrix fields based on size
        for i in 0..<size {
            for j in 0..<size {
                let textField = UITextField()
                textField.borderStyle = .roundedRect
                textField.keyboardType = .numberPad
                textField.tag = tag + (i * size) + j
                matrixView.addSubview(textField)
                
                // Setup constraints for textField
                textField.autoSetDimensions(to: CGSize(width: 40, height: 40))
                
                if j == 0 { // first column
                    textField.autoPinEdge(toSuperviewEdge: .leading)
                } else {
                    textField.autoPinEdge(.leading, to: .trailing, of: previousTextField!)
                }
                
                if i == 0 { // first row
                    textField.autoPinEdge(toSuperviewEdge: .top)
                } else {
                    // Align textField to the one above it
                    if let aboveTextField = matrixView.viewWithTag(textField.tag - size) as? UITextField {
                        textField.autoPinEdge(.top, to: .bottom, of: aboveTextField)
                    }
                }
                
                previousTextField = textField
                
                if j == size - 1 { // last column
                    textField.autoPinEdge(toSuperviewEdge: .trailing)
                }
                
                if i == size - 1 { // last row
                    textField.autoPinEdge(toSuperviewEdge: .bottom)
                }
            }
            previousTextField = nil // reset for the next row
        }
        return matrixView
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
    
    func createGraph(from adjacencyMatrix: [[Int]]) -> Graph {
        let graph = Graph()
        let vertexCount = adjacencyMatrix.count
        
        // Add vertices
        for id in 0..<vertexCount {
            let vertex = Vertex(id: id, position: CGPoint.zero)
            graph.addVertex(position: CGPoint(x: 0, y: 0))
        }
        
        // Add edges based on adjacency matrix
        for i in 0..<vertexCount {
            for j in 0..<vertexCount {
                if adjacencyMatrix[i][j] == 1 && i != j { // Check for edge and avoid self-loops
                    graph.addEdge(from: graph.vertices[i], to: graph.vertices[j])
                }
            }
        }
        
        return graph
    }
}
