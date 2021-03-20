//
//  Image+Ext.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

extension Image {
    
    init(icon: Icon) {
        self.init(systemName: icon.systemName)
    }
    
}
