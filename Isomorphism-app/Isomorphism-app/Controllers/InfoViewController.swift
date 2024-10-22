import UIKit
import PureLayout

class InfoViewController: UIViewController {
    let contentView = UIView()
    let titleLabel = UILabel()
    let versionLabel = UILabel()
    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    let backgroundGraphView = GraphBackgroundView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 130/255, green: 181/255, blue: 230/255, alpha: 1)
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        backgroundGraphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundGraphView)
        view.sendSubviewToBack(backgroundGraphView)

        contentView.backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.4)
        contentView.layer.cornerRadius = 12.0
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 1).cgColor
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)

        titleLabel.text = "Provjera izomorfizma grafova"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        
        versionLabel.text = "Verzija 1.0"
        versionLabel.font = UIFont.systemFont(ofSize: 18)
        versionLabel.textAlignment = .center
        versionLabel.textColor = .black
        contentView.addSubview(versionLabel)
        
        descriptionLabel.text = "Ova aplikacija služi za provjeru izomorfnosti dvaju grafova unesenih grafički ili matrično, koristeći algoritam koji računa certifikate grafova te ih uspoređuje. Ako 2 grafa imaju isti certifikat oni su izomorfni, u suprotnom nisu izomorfni."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        
        authorLabel.text = "Razvila : Lora Zubić"
        authorLabel.font = UIFont.italicSystemFont(ofSize: 16)
        authorLabel.textAlignment = .center
        authorLabel.textColor = .black
        contentView.addSubview(authorLabel)
    }

    private func setupConstraints() {
        backgroundGraphView.autoPinEdgesToSuperviewEdges()

        contentView.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        contentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 400)
        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: 30)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 30)

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)

        versionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        versionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        versionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: versionLabel, withOffset: 20)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)

        authorLabel.autoPinEdge(.top, to: .bottom, of: descriptionLabel, withOffset: 20)
        authorLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        authorLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        authorLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
    }
}
