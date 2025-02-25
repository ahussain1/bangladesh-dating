//
//  HomeBottomControlsStackView.swift
//  BangladeshDating
//  Created on 2/2/25.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true

        //color - #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)

        let subviews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(img, for: .normal)
//            button.contentMode = .scaleAspectFit
            button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }

        subviews.forEach { (v) in
            addArrangedSubview(v)

        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implented")
    }
}

