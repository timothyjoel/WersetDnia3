//
//  FirebaseDatabasePath.swift
//  FirebaseDatabasePath
//
//  Created by Tymoteusz Stokarski on 31/07/2021.
//

import Foundation
import FirebaseDatabase
//import FirebaseAuth

public enum FirebaseDatabasePath {
    
    case likes(Verse)
    case verses
    case verse(Verse)

    public var keys: DatabaseReference {
        switch self {
        case .likes(let verse):
            return Database.database().reference().child(Path.verses).child("\(verse.id)").child(Path.likes)
        case .verses:
            return Database.database().reference().child(Path.verses)
        case .verse(let verse):
            return Database.database().reference().child(Path.verses).child("\(verse.id)")
        }
    }
    
}

extension FirebaseDatabasePath {
    
    private struct Path {
        static let verses = "verses"
        static let likes = "likes"
    }
    
}
