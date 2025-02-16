//
//  CardView.swift
//  BangladeshDating
//


import UIKit

class CardView: UIStackView {

    fileprivate let imageView = UIImageView(image: UIImage(named:"jane1.png"))
    fileprivate let threshold: CGFloat = 100

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()

        let panGesture  = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }

    @objc fileprivate func handlePan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
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
        let shouldDismissCard = gesture.translation(in: nil).x > threshold

        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 1000, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }

        }) { (_ ) in
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }

    required init(coder: NSCoder) {
        fatalError()
    }

}
