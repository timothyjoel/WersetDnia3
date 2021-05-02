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
    case heart
    
    var systemName: String {
        switch self {
        case .alarm:            return "alarm"
        case .questionMark:     return "questionmark"
        case .book:             return "book"
        case .star:             return "star.fill"
        case .info:             return "info"
        case .lightBulb:        return "lightBulb"
        case .reload:           return "arrow.clockwise"
        case .message:          return "message.fill"
        case .mail:             return "envelope"
        case .profile:          return "person"
        case .arrowLeft:        return "chevron.left"
        case .arrowRight:       return "chevron.right"
        case .heart:            return "heart.fill"
        }
    }
    
}

enum CustomImage {
    
    case leftArrow
    case rightArrow
    case calendar
    case menu
    
    var name: String {
        switch self {
        case .leftArrow:        return "left_arrow"
        case .rightArrow:       return "right_arrow"
        case .calendar:         return "calendar"
        case .menu:             return "menu"
        }
    }
    
    
}
