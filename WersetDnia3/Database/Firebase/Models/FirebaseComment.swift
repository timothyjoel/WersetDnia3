//
//  FirebaseComment.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 26/03/2021.
//

import Foundation

typealias FirebaseCommentsDict = [[String: Any]]

struct FirebaseComment: Codable {
    
    var date: String
    var author: String
    var text: String
    var likes: Int
    var reports: Int
    
    var dict: [String: Any] {
            [
            "author": self.author,
            "text": self.text,
            "date" : self.date,
            "likes" : self.likes,
            "reports" : self.reports
            ]
    }
    
}
