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
    
    private var verses: [Verse] = []
    private var likedVerses: [Verse] = []
    private var dataManager = LikedVersesDataManager.shared
    
    // MARK: - Wrapped properties
    
    @Published var date = Date()
    @Published var verse: Verse?
    @Published var isLiked: Bool = false
    
    // MARK: - Iniitializers
    
    init() {
        self.fetchData()
        self.setTodayVerse()
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
        self.verses = Bundle.main.decode([Verse].self, from: .verses)
    }
    
    private func fetchLikedVerses() {
        dataManager.fetchVerses { self.likedVerses = $0 }
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
        dataManager.save(verse)
        likedVerses.append(verse)
        setHeartState()
    }
    
    private func unlikeVerse() {
        guard let verse = verse else { return }
        dataManager.delete(verse)
        likedVerses = likedVerses.filter { $0.path != verse.path }
        setHeartState()
    }
    
}
