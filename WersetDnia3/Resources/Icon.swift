//
//  Icon.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import Foundation

enum Icon {
    
    case alarm
    case questionMark
    case book
    case star
    case info
    case lightBulb
    case reload
    case message
    case mail
    case profile
    case arrowLeft
    case arrowRight
    
    var systemName: String {
        switch self {
        case .alarm:            return "alarm"
        case .questionMark:     return "questionmark"
        case .book:             return "book"
        case .star:             return "star"
        case .info:             return "info"
        case .lightBulb:        return "lightBulb"
        case .reload:           return "arrow.clockwise"
        case .message:          return "message"
        case .mail:             return "envelope"
        case .profile:          return "person"
        case .arrowLeft:        return "chevron.left"
        case .arrowRight:       return "chevron.right"
        }
    }
    
}

enum CustomImage {
    
    case leftArrow
    case rightArrow
    
    var name: String {
        switch self {
        case .leftArrow: return "left_arrow"
        case .rightArrow: return "right_arrow"
        }
    }
    
    
}
