//
//  RemoteDatabaseManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 24/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestoreSwift
import os.log

class FirebaseDataManager {

    // MARK: - Properties
    
    static let shared = FirebaseDataManager()
    private let firebase = Database.database().reference().child("verses")

    // MARK: - Initializers
    
    private init() {}

    // MARK: - Methods
    
    func update(_ verse: FirebaseVerse, like: FirebaseAction) {
        firebase
            .child("\(verse.id)")
            .child(FirebaseParameter.like.rawValue)
            .runTransactionBlock { currentData in
                let value = currentData.value as? Int ?? 0
                currentData.value = value + (like == .add ? 1 : -1)
                return TransactionResult.success(withValue: currentData)
            }
        os_log(.info, log: .firebase, "Updated verse likes")
    }
    
    func load(completion: @escaping ([FirebaseVerse]) -> Void) {
        os_log(.info, log: .firebase, "Start loading verses from firebase...")
        firebase.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                os_log(.info, log: .firebase, "Failed to load verses from firebase")
                completion([]);  return }
            var verses = [FirebaseVerse]()
            children.forEach { [weak self] snap in
                guard let id = Int(snap.key) else { return }
                guard let data = self?.data(from: snap.value) else { return }
                verses.append(FirebaseVerse(id: id, likes: data.likes, comments: data.comments))
            }
            os_log(.info, log: .firebase, "Loaded verses")
            completion(verses)
        }
    }
    
    // MARK: - Helpers
    
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

enum FirebaseParameter: String {
    
    case like = "likes"
    case comment = "comments"
    
}

enum FirebaseAction {
    
    case add
    case remove
    
}
