//
//  DataFile.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import Foundation
import UIKit

let deviceID = UIDevice.current.identifierForVendor!.uuidString

enum DataFile {
    
    case verses
    case funFacts
    
    var file: String {
        switch self {
        case .verses:   return "verses.json"
        case .funFacts: return "funFacts.json"
        }
    }
    
}
