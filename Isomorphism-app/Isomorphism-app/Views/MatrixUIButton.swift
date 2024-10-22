import UIKit

class MatrixUIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Postavljanje početnog stanja dugmeta
        setTitle("0", for: .normal)
        setTitle("1", for: .selected)
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.4)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        
        // Dodavanje akcije za promenu stanja
        addTarget(self, action: #selector(toggleText), for: .touchUpInside)
        
        // Postavljanje veličine dugmeta
        frame.size = CGSize(width: 40, height: 40)
    }
    
    @objc private func toggleText() {
        isSelected.toggle()
        // Animacija promene boje pozadine
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = self.isSelected ? UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.8) : UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.4)
        }
    }
}
