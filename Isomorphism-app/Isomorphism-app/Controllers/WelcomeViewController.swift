import UIKit
import PureLayout

class WelcomeViewController: UIViewController {
    var drawButton = UIButton()
    var matrixButton = UIButton()
    var welcomeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        editViews()
        setupConstraints()
        view.backgroundColor = .white
        
    }
    
    func setupConstraints() {
        welcomeLabel.autoPinEdge(.top, to: .top, of: view, withOffset: 80)
        welcomeLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        welcomeLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        
        drawButton.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 150)
        drawButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        drawButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        drawButton.autoSetDimension(.height, toSize: 50)
        
        matrixButton.autoPinEdge(.top, to: .bottom, of: drawButton, withOffset: 20)
        matrixButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        matrixButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        matrixButton.autoSetDimension(.height, toSize: 50)
    }
    
    func editViews() {
        drawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        drawButton.backgroundColor = UIColor.systemBlue
        drawButton.layer.cornerRadius = 10
        drawButton.setTitle("Draw graphs", for: .normal)
        drawButton.layer.shadowColor = UIColor.black.cgColor
        drawButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        drawButton.layer.shadowRadius = 5
        drawButton.layer.shadowOpacity = 0.5
        drawButton.layer.masksToBounds = false
        view.addSubview(drawButton)
        
        matrixButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        matrixButton.backgroundColor = UIColor.systemBlue
        matrixButton.layer.cornerRadius = 10
        matrixButton.setTitle("Insert graphs matrices", for: .normal)
        matrixButton.layer.shadowColor = UIColor.black.cgColor
        matrixButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        matrixButton.layer.shadowRadius = 5
        matrixButton.layer.shadowOpacity = 0.5
        matrixButton.layer.masksToBounds = false
        view.addSubview(matrixButton)
        
        welcomeLabel.text = "Choose the way of inserting your graphs!"
        welcomeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 50)
        welcomeLabel.numberOfLines = 0
        view.addSubview(welcomeLabel)
        
        drawButton.addTarget(self, action: #selector(vertexEdgeButtonTapped), for: .touchUpInside)
        matrixButton.addTarget(self, action: #selector(matrixButtonTapped), for: .touchUpInside)
    }
    
    @objc func vertexEdgeButtonTapped() {
        let viewController = DrawViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func matrixButtonTapped() {
        let viewController = MatrixViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
