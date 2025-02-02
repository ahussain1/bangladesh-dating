//
//  ViewController.swift
//  BangladeshDating
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        let topStackView = UIStackView(arrangedSubviews: subviews)
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let blueView = UIView()
        blueView.backgroundColor = .blue
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.heightAnchor.constraint(equalToConstant: 120).isActive = true

        let stackView = UIStackView(arrangedSubviews: [topStackView, blueView, yellowView])
//        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.frame = .init(x: 0, y: 0, width: 300, height: 300)
        stackView.fillSuperview()

//        // enables autolayout
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }


}

