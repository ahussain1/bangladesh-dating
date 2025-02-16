//
//  ViewController.swift
//  BangladeshDating
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let buttonStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView() // Use a plain UIView instead of UIStackView

    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Student", imageName: "jane2"),
            User(name: "Jenna", age: 25, profession: "Student", imageName: "karen1"),
            Advertiser(title: "Slide Out Menu", brandName: "Apple Inc", posterPhotoName: "slide_out_menu_poster")
        ] as [ProducesCardViewModel]

        let viewModels = producers.map({ $0.toCardViewModel()})
        return viewModels
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDummyCards()
        setupLayout()
    }

    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
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
