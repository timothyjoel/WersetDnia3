//
//  os_log+Ext.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import os.log
import Foundation

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs related to view cycle
    static let view = OSLog(subsystem: subsystem, category: "View")
    /// Logs related to viewModels
    static let viewModel = OSLog(subsystem: subsystem, category: "ViewModel")
    /// Logs related to data management processes - CRUD
    static let coreData = OSLog(subsystem: subsystem, category: "CoreData")
    /// Logs related to data management processes - CRUD
    static let firebase = OSLog(subsystem: subsystem, category: "Firebase")
    
}
