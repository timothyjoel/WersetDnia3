//
//  DatabaseManager.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 27/03/2021.
//

import Foundation

class DatabaseManager {

    // MARK: - Properties
    
    static let shared = DatabaseManager()
    
    private let likedVersesManager = VerseDataManager.shared
    private let firebaseDataManager = FirebaseDataManager.shared

    // MARK: - Initializers
    
    private init() {}

    // MARK: - Methods
    
    func add(like verse: FirebaseVerse?) {
        guard let verse = verse else { return }
        likedVersesManager.add(verse)
        firebaseDataManager.add(like: verse)
    }
    
    func remove(like verse: FirebaseVerse?) {
        guard let verse = verse else { return }
        likedVersesManager.remove(verse)
        firebaseDataManager.remove(like: verse)
    }
    
    
    func load(completion: @escaping (_ verses: [FirebaseVerse]) -> Void) {
        var allVerses = Bundle.main.decode([FirebaseVerse].self, from: .verses)
        likedVersesManager.fetchLikedVerses { likedVerses in
            likedVerses.forEach { verseID in
                if let index = allVerses.firstIndex(where: { $0.id == verseID }) { allVerses[index].likedLocally = true }
            }
        }
        firebaseDataManager.load { firebaseVerses in
            firebaseVerses.forEach { verse in
                if let index = allVerses.firstIndex(where: { $0.id == verse.id }) {
                    allVerses[index].likes = verse.likes
                    allVerses[index].comments = verse.comments
                }
            }
            completion(allVerses)
        }
    }
    
//    func load(completion: @escaping (_ verses: [FirebaseVerse], _ likedVerses: [FirebaseVerse], _ firebaseVerses: [FirebaseVerse]) -> Void) {
//        let verses = Bundle.main.decode([FirebaseVerse].self, from: .verses)
//        var likedVerses = [Verse]()
//        verseDataManager.fetchVerses { likedVerses = $0 }
//        firebaseDataManager.load { completion(verses, likedVerses, $0) }
//    }
    

}
