//
//  RemoteDatabaseManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {

    // MARK: - Properties
    
    static let shared = FirebaseManager()
    
    // MARK: - Initializers
    
    private init() {}

    // MARK: - Methods
    
    public func like(_ verse: Verse) {
        FirebaseDatabasePath
            .likes(verse).keys
            .child(User().id)
            .setValue(User().dict)
    }
    
    public func unlike(_ verse: Verse) {
        FirebaseDatabasePath
            .likes(verse).keys
            .child(User().id)
            .removeValue()
    }
    
    func observe(_ verse: Verse, completion: @escaping (Result<[User]?, FirebaseError>) -> Void) {
        FirebaseDatabasePath
            .verse(verse)
            .keys
            .observe(.value) { snapshot in
                guard let data = snapshot.value as? [String : Any] else { completion(.success(nil)); return }
                let users = (data["likes"] as? [String:[String:String]])?.compactMap( { $0.value }).compactMap({ User(id: $0["id"]!, name: $0["name"]!, lastName: $0["lastName"]!, avatar: $0["id"] ?? "")})
                completion(.success(users))
            } withCancel: { error in
                completion(.failure(.CancelError))
            }
    }
    
    
//    func observeVerses(completion: @escaping (Result<[FirebaseVerse], FBError>) -> Void) {
//        os_log(.info, log: .firebase, "Start loading verses from firebase...")
//        FireDatabase.verses.keys.observe(.value) { snapshot in
//            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
//                os_log(.info, log: .firebase, "Failed to load verses from firebase")
//                completion(.failure(.failedToLoad)); return }
//            let firebaseVerses = children.compactMap({ snap -> FirebaseVerse? in
//                let verseData = snap.value as? [String: Any]
//                let likes = verseData?["likes"] as? FirebaseUser
//                let users = likes?.compactMap( { $0.value }).compactMap({ User(id: $0["id"]!, name: $0["name"]!, lastName: $0["lastName"]!, avatar: $0["id"] ?? "")})
//                return FirebaseVerse(id: Int(snap.key)!, likes: users, comments: nil)
//            })
//            completion(.success(firebaseVerses))
//        } withCancel: { error in
//            completion(.failure(.CancelError))
//        }
//    }
    
    // MARK: - Helpers
    
//    private func data(from verse: Any?) -> FirebaseVerse? {
//        do {
//            guard let verse = verse else { return nil }
//            let jsonData =  try! JSONSerialization.data(withJSONObject: verse, options: [])
//            let decodedVerse = try JSONDecoder().decode(FirebaseVerse.self, from: jsonData)
//            return decodedVerse
//        } catch let error {
//            os_log(.error, log: .firebase, "Error when decoding verse: %@", error.localizedDescription)
//            return nil
//        }
//    }

}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
