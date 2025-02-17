//
//  CardViewModel.swift
//  BangladeshDating
//
//  Created on 2/16/25.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    // we'll define the properties that are view will
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}


