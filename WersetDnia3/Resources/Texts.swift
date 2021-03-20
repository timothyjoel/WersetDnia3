//
//  Texts.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import Foundation

enum TabViewTitle {
    
    case alarm
    case roll
    case likedVerse
    case verse
    case info
    
    var text: String {
        switch self {
        case .alarm:        return "Alarm"
        case .roll:         return "Losuj"
        case .likedVerse:   return "Ulubione"
        case .verse:        return "Werset dnia"
        case .info:         return "Info"
        }
    }
    
}
