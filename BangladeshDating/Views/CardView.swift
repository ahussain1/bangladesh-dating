//
//  CardView.swift
//  BangladeshDating
//


import UIKit

class CardView: UIStackView {

    var cardViewModel: CardViewModel! {
        didSet {
            // accessing index 0 will crash if imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment

            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
        }
    }

    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "top_right_messages"))
    fileprivate let informationLabel =  UILabel()
    fileprivate let threshold: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()

        setupBarsStackView()
        setupGradientLayer()

        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.text = "Test name test name"
        informationLabel.textColor = .white
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)

        let panGesture  = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)

    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        print("handleTap")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2  ? true: false

        if shouldAdvanceNextPhoto {
            imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
        } else {
            imageIndex = max(0, imageIndex - 1)
        }

        let imageName = cardViewModel.imageNames[imageIndex]
        imageView.image = UIImage(named: imageName)
        barsStackView.arrangedSubviews.forEach { (v) in
            v.backgroundColor = barDeselectedColor
        }
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    

    fileprivate let barsStackView =  UIStackView()

    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually
    }

    let gradientLayer = CAGradientLayer()

    fileprivate func setupGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        // in here you know what the CardView frame will be
        gradientLayer.frame = self.frame
    }

    @objc fileprivate func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }

    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation
        // convert radians to degrees
        let degrees =  translation.x / 20
        let angle = degrees * .pi / 180
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }

    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold

        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let screenWidth = UIScreen.main.bounds.width
                let translationDirection: CGFloat = translation.x > 0 ? 1 : -1
                self.frame = CGRect(x: translationDirection * (screenWidth + self.frame.width), y: 0, width: self.frame.width, height: self.frame.height)
                self.superview?.subviews.last?.layer.removeAllAnimations()
            } else {
                self.transform = .identity
            }

        }) { (_ ) in
            self.transform = .identity
            self.removeFromSuperview()
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }

    required init(coder: NSCoder) {
        fatalError()
    }

}
