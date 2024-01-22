import UIKit
import PureLayout

class PopUpView: UIView {
    let popUpView = UIView()
    let picker = UIPickerView()
    let confirmButton = UIButton()
    let choices = ["Invarijants algorithm", "Certificates algorithm"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupStyle()
    }
    
    func setupLayout() {
        self.addSubview(popUpView)
        popUpView.autoAlignAxis(toSuperviewAxis: .horizontal)
        popUpView.autoAlignAxis(toSuperviewAxis: .vertical)
        popUpView.autoSetDimensions(to: CGSize(width: 300, height: 200))
        
        popUpView.addSubview(picker)
        picker.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        picker.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        picker.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        picker.autoPinEdge(toSuperviewEdge: .bottom, withInset: 58)
        
        popUpView.addSubview(confirmButton)
        confirmButton.autoPinEdge(toSuperviewEdge: .leading, withInset: 8)
        confirmButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        confirmButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    func setupStyle() {
        self.backgroundColor = .black.withAlphaComponent(0.2)
        popUpView.backgroundColor = .white
        popUpView.layer.cornerRadius = 10
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.backgroundColor = .lightGray
        confirmButton.layer.cornerRadius = 10
    }
    
}

extension PopUpView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        choices[row]
    }
    
    
}
