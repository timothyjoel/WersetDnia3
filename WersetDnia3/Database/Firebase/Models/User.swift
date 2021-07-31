//
//  User.swift
//  User
//
//  Created by Tymoteusz Stokarski on 31/07/2021.
//

import UIKit

struct User: Codable {
    
    /// User's unique ID created based on device
    var id: String
    /// User name
    var name: String
    /// User last name
    var lastName: String
    /// User avatar as URL string
    var avatar: String?
    
    public init(id: String, name: String, lastName: String, avatar: String? = nil) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.avatar = avatar
    }
    
    public init() {
        self.id = UIDevice.current.identifierForVendor?.uuidString ?? ""
        self.name = "User"
        self.lastName = "Last name"
        self.avatar = "Avatar"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        lastName = try values.decode(String.self, forKey: .lastName)
        avatar = try values.decode(String.self, forKey: .avatar)
    }
    
    enum CodingKeys: String, CodingKey {
        case id         = "id"
        case name       = "name"
        case lastName   = "lastName"
        case avatar     = "avatar"
    }
    
    var dict: [String: Any] {
            [
            "id": self.id,
            "name": self.name,
            "lastName" : self.lastName,
            "avatar" : self.avatar ?? ""
            ]
    }
    
}
