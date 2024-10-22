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
        
        setTitle("0", for: .normal)
        setTitle("1", for: .selected)
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(red: 22/255, green: 93/255, blue: 160/255, alpha: 0.4)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        addTarget(self, action: #selector(toggleText), for: .touchUpInside)
        
        frame.size = CGSize(width: 40, height: 40)
    }
    
    @objc private func toggleText() {
        isSelected.toggle()
    }
    
}
