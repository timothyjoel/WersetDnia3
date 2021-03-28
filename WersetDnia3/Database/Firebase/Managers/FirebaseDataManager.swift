//
//  RemoteDatabaseManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestoreSwift
import os.log

class FirebaseDataManager {

    // MARK: - Properties
    
    static let shared = FirebaseDataManager()
    private let db =  Database.database().reference().child("verses")

    // MARK: - Initializers
    
    private init() {}

    // MARK: - Methods
    
    func add(like verse: FirebaseVerse) {
        db.child("\(verse.id)").observeSingleEvent(of: .value) { [weak self] response in
            guard let response = response.value as? [String: Any] else {
                self?.db.child("\(verse.id)").setValue(["likes": 1])
                os_log(.info, log: .firebase, "Added first like to database for verse: %@", verse.path)
                return
            }
            if let likes = response["likes"] as? Int {
                self?.db.child("\(verse.id)").setValue(["likes": likes + 1])
            }
            os_log(.info, log: .firebase, "Added like to database for verse: %@", verse.path)
        }
    }
    
    func remove(like verse: FirebaseVerse) {
        db.child("\(verse.id)").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            if let likes = value["likes"] as? Int {
                self?.db.child("\(verse.id)").setValue(["likes": likes - 1])
            }
            os_log(.info, log: .firebase, "Removed like from database for verse: %@", verse.path)
        }
    }

    func reportComment(_ comment: FirebaseComment, verse: FirebaseVerse) {
        var editedVerse = verse
        editedVerse.comments?.append(comment)
   //     save(editedVerse)
    }
    
    func load(completion: @escaping ([FirebaseVerse]) -> Void) {
        db.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else { return }
            var verses = [FirebaseVerse]()
            children.forEach { [weak self] snap in
                guard let id = snap.key as? Int else { return }
                guard let data = self?.data(from: snap.value) else { return }
                verses.append(FirebaseVerse(id: id, likes: data.likes, comments: data.comments))
            }
            os_log(.info, log: .firebase, "Loaded verses")
            completion(verses)
        }
    }
    
    // MARK: - Helpers
    
//    func save(_ verse: FirebaseVerse) {
//        db.child("\(verse.id)").setValue(verse.dict) { error, dbref in
//            guard error == nil else { os_log(.error, log: .firebase, "Failed to save verse in firebase database"); return }
//            os_log(.info, log: .firebase, "Successfully saved verse to firebase database")
//        }
//    }
    
    private func data(from verse: Any?) -> FirebaseVerse? {
        do {
            guard let verse = verse else { return nil }
            let jsonData =  try! JSONSerialization.data(withJSONObject: verse, options: [])
            let decodedVerse = try JSONDecoder().decode(FirebaseVerse.self, from: jsonData)
            return decodedVerse
        } catch let error {
            os_log(.error, log: .firebase, "Error when decoding verse: %@", error.localizedDescription)
            return nil
        }
    }

}
