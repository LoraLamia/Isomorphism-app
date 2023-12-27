//
//  ViewController.swift
//  Isomorphism-app
//
//  Created by Lora Zubic on 27.12.2023..
//

import UIKit
import PureLayout

class ViewController: UIViewController {
    let graphCanvasView = GraphCanvasView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(graphCanvasView)
                
        graphCanvasView.translatesAutoresizingMaskIntoConstraints = false
        graphCanvasView.autoPinEdgesToSuperviewEdges()

        view.backgroundColor = .yellow
    }


}

