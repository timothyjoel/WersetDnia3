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
    
    
    // MARK: - Wrapped properties
    
    @Published var date = Date()
    @Published var verse: Verse?
    @Published var isLiked: Bool = true
    
    // MARK: - Iniitializers
    
    init() {
        self.setTodayVerse()
    }
    
    
    // MARK: - Methods
    
    func show(_ direction: Calendar.SearchDirection) {
        let index = verses.firstIndex { $0.path == verse?.path }!
        guard index != 0 && index != verses.count - 1 else { return }
        verse = verses[verses.firstIndex { $0.path == verse?.path }! + (direction == .forward ? 1 : -1)]
        date = direction == .forward ? date.tommorrow : date.yesterday
    }
    
    func showToday() {
        date = Date()
        verse = verses[Calendar.current.ordinality(of: .day, in: .year, for: date)!]
    }
    
    private func setTodayVerse() {
        self.verses = Bundle.main.decode([Verse].self, from: .verses)
        if date.isLeapYear { self.verses.remove(at: 59) }
        verse = verses[Calendar.current.ordinality(of: .day, in: .year, for: date)!]
    }
    
    func tapHeartButton() {
        isLiked.toggle()
    }
    
}
