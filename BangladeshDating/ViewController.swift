//
//  ViewController.swift
//  BangladeshDating
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopNavigationStackView()
    let buttonStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView() // Use a plain UIView instead of UIStackView

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDummyCards()
        setupLayout()
    }

    fileprivate func setupDummyCards() {
        print("Setting up dummy cards")
        let cardView = CardView(frame: .zero)
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
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
