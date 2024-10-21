import UIKit

class InfoViewController: UIViewController {
    let infoTextView = UITextView()
    let backgroundGraphView = GraphBackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 130/255, green: 181/255, blue: 230/255, alpha: 1)
        addBackgroundGraphView()
        editViews()
        setupConstraints()
    }
    
    
    
    private func setupConstraints() {
        infoTextView.autoPinEdge(.top, to: .top, of: view, withOffset: 70)
        infoTextView.autoPinEdge(.leading, to: .leading, of: view, withOffset: 50)
        infoTextView.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -50)
        infoTextView.autoSetDimension(.height, toSize: 400)
    }
    
    private func editViews() {
        view.addSubview(infoTextView)
        infoTextView.backgroundColor = .white
        infoTextView.textColor = .black
        infoTextView.font = UIFont.systemFont(ofSize: 20.0)
        infoTextView.text = "With this app you can check if 2 graphs are isomorphic using algorithm that calculater certificates of both garphs and then compares them."
        infoTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        infoTextView.textContainer.lineFragmentPadding = 5
        infoTextView.clipsToBounds = true;
        infoTextView.layer.cornerRadius = 12.0;
        infoTextView.layer.borderColor = CGColor.init(red: 22/255, green: 93/255, blue: 160/255, alpha: 1)
        infoTextView.layer.borderWidth = 6
    }
    
    private func addBackgroundGraphView() {
        backgroundGraphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundGraphView)
        view.sendSubviewToBack(backgroundGraphView)
        
        // Set constraints to cover the entire view
        NSLayoutConstraint.activate([
            backgroundGraphView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGraphView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGraphView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundGraphView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
