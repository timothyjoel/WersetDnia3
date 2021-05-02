//
//  FirebaseVerse.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import Firebase

struct FirebaseVerse: Codable {
    
    // MARK: - Properties
    
    var id: Int
    let path: String
    let text: String
    let image: String
    var likes: Int
    var likedLocally: Bool = false
    var comments: [FirebaseComment]?
    var commentsDict: FirebaseCommentsDict?
    

    // MARK: - Initializers
    
    init(id: Int, path: String = "", text: String = "", image: String = "", likes: Int = 0, comments: [FirebaseComment]?) {
        self.id = id
        self.path = path
        self.text = text
        self.likes = likes
        self.comments = comments
        self.image = image
        self.commentsDict = comments?.map({ $0.dict })
    }

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        id = snapshotValue["id"] as? Int ?? 0
        path = snapshotValue["path"] as? String ?? ""
        text = snapshotValue["text"] as? String ?? ""
        likes = snapshotValue["likes"] as? Int ?? 0
        image = snapshotValue["image"] as? String ?? ""
        commentsDict = snapshotValue["comments"] as? FirebaseCommentsDict
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        path = try values.decodeIfPresent(String.self, forKey: .path) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
        likes = try values.decodeIfPresent(Int.self, forKey: .likes) ?? 0
        comments = try values.decodeIfPresent([FirebaseComment].self, forKey: .comments)
        commentsDict = comments?.map({ $0.dict })
    }
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case likes      = "likes"
        case comments   = "comments"
        case path       = "path"
        case text       = "text"
        case image      = "image"
    }
    
    // MARK: - Methods

    var dict: NSDictionary {
        return [
            "id": id,
            "path": path,
            "text": text,
            "likes": likes,
            "comments": commentsDict ?? ""
        ]
    }

 }
