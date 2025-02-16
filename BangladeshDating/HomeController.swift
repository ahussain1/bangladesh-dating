//
//  ViewController.swift
//  BangladeshDating
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let buttonStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView() // Use a plain UIView instead of UIStackView

    let users = [
        User(name: "Kelly", age: 23, profession: "Student", imageName: "jane2"),
        User(name: "Jenna", age: 25, profession: "Student", imageName: "karen1"),
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDummyCards()
        setupLayout()
    }

    fileprivate func setupDummyCards() {
        users.forEach { (user) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: user.imageName)
            cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"

            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
            attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .light)]))

            attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))


            cardView.informationLabel.attributedText = attributedText

            cardView.informationLabel.numberOfLines = 0
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }

    fileprivate func setupLayout() {
        // Create a container view for the cards
        let cardsContainerView = UIView()
        cardsContainerView.addSubview(cardsDeckView)
        cardsDeckView.fillSuperview()

        // Create the overall stack view
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsContainerView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)

        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)

        // Ensure the cardsDeckView is above the buttons
        cardsContainerView.bringSubviewToFront(cardsDeckView)
    }
}
