import UIKit
import PureLayout

class WelcomeViewController: UIViewController {
    var drawButton = UIButton()
    var matrixButton = UIButton()
    var welcomeLabel = UILabel()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        editViews()
        setupConstraints()
        view.backgroundColor = .white
        
    }
    
    func setupConstraints() {
        welcomeLabel.autoPinEdge(.top, to: .top, of: view, withOffset: 120)
        welcomeLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        welcomeLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        
        drawButton.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 20)
        drawButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        drawButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        drawButton.autoSetDimension(.height, toSize: 50)
        
        matrixButton.autoPinEdge(.top, to: .bottom, of: drawButton, withOffset: 20)
        matrixButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        matrixButton.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        matrixButton.autoSetDimension(.height, toSize: 50)
        
        imageView.autoPinEdge(.top, to: .bottom, of: matrixButton, withOffset: 20)
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoSetDimensions(to: CGSize(width: 270, height: 270))
    }
    
    func editViews() {
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        welcomeLabel.text = "Choose the way of inserting your graphs!"
        welcomeLabel.textColor = UIColor(red: 0, green: 0, blue: 0.6, alpha: 0.2)
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 50)
        welcomeLabel.numberOfLines = 0
        view.addSubview(welcomeLabel)
        
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
        
        if let image = UIImage(named: "graphs") {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
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
    
    @objc func infoButtonTapped() {
        let viewController = InfoViewController()
        self.present(viewController, animated: true)
    }
    
}
