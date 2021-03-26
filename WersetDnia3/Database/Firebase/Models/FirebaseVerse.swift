//
//  FirebaseVerse.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import Firebase

struct FirebaseVerse: Decodable {
    
    // MARK: - Properties
    
    var id: Int
    var likes: Int
    var comments: [FirebaseComment]?
    var commentsDict: CommentsDict?
    

    // MARK: - Initializers
    
    init(id: Int, likes: Int, comments: [FirebaseComment]) {
        self.id = id
        self.likes = likes
        self.comments = comments
        self.commentsDict = comments.map({ $0.dict })
    }

    init(snapshot: DataSnapshot) {
         let snapshotValue = snapshot.value as! [String: AnyObject]
         id = snapshotValue["id"] as! Int
         likes = snapshotValue["likes"] as! Int
         commentsDict = snapshotValue["comments"] as? CommentsDict
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        likes = try values.decode(Int.self, forKey: .likes)
        comments = try values.decode([FirebaseComment].self, forKey: .comments)
        commentsDict = comments?.map({ $0.dict })
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case likes = "likes"
        case comments = "comments"
    }
    
    // MARK: - Methods

    var dict: NSDictionary {
        return [
            "id": id,
            "likes": likes,
            "comments": commentsDict ?? ""
        ]
    }

 }
