//
//  FirebaseDataManager.swift
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
    
    func likeVerse(_ like: Bool, verse: FirebaseVerse) {
        var editedVerse = verse
        editedVerse.likes += like ? 1 : -1
        save(editedVerse)
    }
    
    func addComment(_ comment: FirebaseComment, verse: FirebaseVerse) {
        var editedVerse = verse
        editedVerse.comments?.append(comment)
        save(editedVerse)
    }
    
    func likeComment(_ like: Bool, comment: FirebaseComment, verse: FirebaseVerse) {
        var editedVerse = verse
        guard let index = editedVerse.comments?.firstIndex(where: { $0.date == comment.date }) else { return }
        editedVerse.comments?[index].likes += like ? 1 : -1
        save(editedVerse)
    }
    
    func reportComment(_ comment: FirebaseComment, verse: FirebaseVerse) {
        var editedVerse = verse
        editedVerse.comments?.append(comment)
        save(editedVerse)
    }
    
    func loadVerses() {
        db.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else { return }
            var verses = [FirebaseVerse]()
            children.forEach { [weak self] snap in
                guard let verse = self?.verse(from: snap.value) else { return }
                verses.append(FirebaseVerse(id: verse.id, likes: verse.likes, comments: verse.comments ?? []))
            }
            os_log(.info, log: .firebase, "Successfully loaded verses from firebase database")
        }
    }
    
    // MARK: - Helpers
    
    private func save(_ verse: FirebaseVerse) {
        db.child("\(verse.id)").setValue(verse.dict) { error, dbref in
            guard error == nil else { os_log(.error, log: .firebase, "Failed to save verse in firebase database"); return }
            os_log(.info, log: .firebase, "Successfully saved verse to firebase database")
        }
    }
    
    private func verse(from verse: Any?) -> FirebaseVerse? {
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
