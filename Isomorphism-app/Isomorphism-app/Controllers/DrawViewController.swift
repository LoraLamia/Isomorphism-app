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
    }
    
    func setupConstraints() {
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(.top, to: .bottom, of: graphCanvasView)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
    
    @objc func checkIsomorphism() {
        print("SAD")
    }
    
    
}


