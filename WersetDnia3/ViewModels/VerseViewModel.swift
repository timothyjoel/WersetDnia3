//
//  VerseViewModel.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import Combine
import Foundation
import SwiftUI

class VerseViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private var verses: [LocalVerse] = []
    private var likedVerses: [LocalVerse] = []
    
    private var coreDataManager = LikedVersesDataManager.shared
    private var firebaseManager = FirebaseDataManager.shared
    
    // MARK: - Wrapped properties
    
    @Published var date = Date()
    @Published var verse: LocalVerse?
    @Published var isLiked: Bool = false
    
    // MARK: - Iniitializers
    
    init() {
        self.fetchData()
        self.setTodayVerse()
        firebaseManager.likeVerse(true, verse: FirebaseVerse(id: 2, likes: 5, comments: [FirebaseComment(date: "wczoraj", author: "Melman", text: "Czesc", likes: 0, reports: 0)]))
        firebaseManager.loadVerses()
    }
    
    // MARK: - Methods
    
    func showToday() {
        date = Date()
        verse = verses[Calendar.current.ordinality(of: .day, in: .year, for: date)!]
        setHeartState()
    }
    
    func show(_ direction: Calendar.SearchDirection) {
        let index = verses.firstIndex { $0.path == verse?.path }!
        guard index != 0 && index != verses.count - 1 else { return }
        verse = verses[verses.firstIndex { $0.path == verse?.path }! + (direction == .forward ? 1 : -1)]
        date = direction == .forward ? date.tommorrow : date.yesterday
        setHeartState()
    }
    
    func tapHeartButton() {
        isLiked ? unlikeVerse() : likeVerse()
    }
    
    
    // MARK: - Private methods
    
    private func fetchData() {
        fetchVerses()
        fetchLikedVerses()
    }
    
    private func fetchVerses() {
        self.verses = Bundle.main.decode([LocalVerse].self, from: .verses)
    }
    
    private func fetchLikedVerses() {
        coreDataManager.fetchVerses { self.likedVerses = $0 }
        isLiked = likedVerses.contains(where: { $0.path == verse?.path}) ? true : false
    }
    
    private func setTodayVerse() {
        if date.isLeapYear { self.verses.remove(at: 59) }
        verse = verses[Calendar.current.ordinality(of: .day, in: .year, for: date)!]
        setHeartState()
    }
    
    private func setHeartState() {
        isLiked = likedVerses.contains(where: { $0.path == verse?.path })
    }
    
    private func likeVerse() {
        guard let verse = verse else { return }
        coreDataManager.save(verse)
        likedVerses.append(verse)
        setHeartState()
    }
    
    private func unlikeVerse() {
        guard let verse = verse else { return }
        coreDataManager.delete(verse)
        likedVerses = likedVerses.filter { $0.path != verse.path }
        setHeartState()
    }
    
}
