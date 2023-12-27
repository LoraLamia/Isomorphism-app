//
//  ViewController.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    var graphCanvasView = GraphCanvasView()
    var checkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        graphCanvasView = GraphCanvasView.newAutoLayout()
        view.addSubview(graphCanvasView)
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))

        setupCheckButton()
    }
    
    func setupCheckButton() {
        checkButton = UIButton.newAutoLayout()
        checkButton.setTitle("PROVJERI", for: .normal)
        checkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        checkButton.backgroundColor = UIColor.systemBlue
        checkButton.tintColor = UIColor.white
        checkButton.layer.cornerRadius = 8
        
        view.addSubview(checkButton)
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
        
        checkButton.addTarget(self, action: #selector(checkIsomorphism), for: .touchUpInside)
    }
    
    @objc func checkIsomorphism() {
        // Ovdje će biti logika za provjeru izomorfnosti grafova
    }


}

