//
//  LottieAnimation.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import Foundation

enum LottieAnimation {
    
    case heart
    
    var name: String {
        switch self {
        case .heart: return "heartAnimation"
        }
    }
    
}
