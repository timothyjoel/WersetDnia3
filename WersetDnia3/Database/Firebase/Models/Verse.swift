//
//  FirebaseVerse.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import Firebase
import UIKit

public struct Verse: Codable {
    
    // MARK: - Properties
    
    var id: Int
    let path: String
    let text: String
    let image: String
    var likes: [User]?
    var comments: [Comment]?

    // MARK: - Initializers
    
    init(id: String = "", path: String = "", text: String = "", image: String = "", likes: [User]?, comments: [Comment]?) {
        self.id = Int(id)!
        self.path = path
        self.text = text
        self.likes = likes
        self.comments = comments
        self.image = image
    }

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as? Int ?? 0
        path = snapshotValue["path"] as? String ?? ""
        text = snapshotValue["text"] as? String ?? ""
        image = snapshotValue["image"] as? String ?? ""
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        path = try values.decodeIfPresent(String.self, forKey: .path) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
        likes = try values.decodeIfPresent([User].self, forKey: .likes)
        comments = try values.decodeIfPresent([Comment].self, forKey: .comments)
    }
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case likes      = "likes"
        case comments   = "comments"
        case path       = "path"
        case text       = "text"
        case image      = "image"
    }

 }
