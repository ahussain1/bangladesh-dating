//
//  Advertiser.swift
//  BangladeshDating
//
//  Created on 2/16/25.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String

    func toCardViewModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedString.append(NSAttributedString(string: "\n" + brandName, attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .regular)]))

        return CardViewModel(imageNames: [posterPhotoName], attributedString: attributedString, textAlignment: .center)
    }
}
