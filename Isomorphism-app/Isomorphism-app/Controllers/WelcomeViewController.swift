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
        let infoButton = UIButton(type: .system)
        let infoImage = UIImage(systemName: "info.circle")
        infoButton.setImage(infoImage, for: .normal)
        infoButton.tintColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8) // Set the desired color
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        welcomeLabel.text = "Odaberi način na koji želiš unijeti svoje grafove!"
        welcomeLabel.textColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.3)
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 50)
        welcomeLabel.numberOfLines = 0
        view.addSubview(welcomeLabel)
        
        drawButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        drawButton.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        drawButton.layer.cornerRadius = 10
        drawButton.setTitle("Grafički unos", for: .normal)
        drawButton.layer.shadowColor = UIColor.black.cgColor
        drawButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        drawButton.layer.shadowRadius = 5
        drawButton.layer.shadowOpacity = 0.5
        drawButton.layer.masksToBounds = false
        view.addSubview(drawButton)
        
        matrixButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        matrixButton.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8)
        matrixButton.layer.cornerRadius = 10
        matrixButton.setTitle("Unos matrica susjedstva", for: .normal)
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
