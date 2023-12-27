//
//  ViewController.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import UIKit
import PureLayout

class ViewController: UIViewController {
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
        
        checkButton = UIButton()
        checkButton.setTitle("PROVJERI", for: .normal)
        checkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        checkButton.backgroundColor = UIColor.systemBlue
        checkButton.tintColor = UIColor.white
        checkButton.layer.cornerRadius = 8
        view.addSubview(checkButton)
        checkButton.addTarget(self, action: #selector(checkIsomorphism), for: .touchUpInside)
    }
    
    func setupConstraints() {
        graphCanvasView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        checkButton.autoAlignAxis(toSuperviewAxis: .vertical)
        checkButton.autoPinEdge(.top, to: .bottom, of: graphCanvasView, withOffset: 20)
        checkButton.autoSetDimensions(to: CGSize(width: 200, height: 50))
    }
    
    @objc func checkIsomorphism() {
        print(graphCanvasView.graphOne.vertices)
        print(graphCanvasView.graphTwo.vertices)
    }
    
    
}


