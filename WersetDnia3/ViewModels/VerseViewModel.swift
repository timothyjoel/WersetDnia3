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
    
    private let fb = FirebaseManager.shared
    
    @Published var verses: [Verse]
    @Published var date = Date()
    
    // MARK: - Iniitializers
    
    init() {
        verses = Bundle.main.decode([Verse].self, from: .verses)
        adjustToLeapYear()
    }
    
    // MARK: - Methods
    
    func showToday() {
        date = Date()
    }
    
    func show(_ direction: Calendar.SearchDirection) {
        switch direction {
        case .backward:
            guard Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 0 > 1 else { return }
            date = date.yesterday
        case .forward:
            guard Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 0 < verses.count else { return }
            date = date.tommorrow
        default: break
        }
        observeVerse()
    }
    
    func tapStar() {
        guard let index = Calendar.current.ordinality(of: .day, in: .year, for: date) else { return }
        let verse = verses[index]
        let like = verse.likes?.contains(where: { $0.id ==  deviceID }) ?? false
        !like ? fb.like(verse) : fb.unlike(verse)
    }
    
    
    // MARK: - Data Fetching methods
    
    func observeVerse() {
        guard let index = Calendar.current.ordinality(of: .day, in: .year, for: date) else { return }
        fb.observe(verses[index]) { [weak self] result in
            switch result {
            case .success(let likes):
                self?.verses[index].likes = likes
            case .failure(let error):
                print("handle error: \(error.localizedDescription)")
            }
        }
    }
    
    private func adjustToLeapYear() {
        if date.isLeapYear { self.verses.remove(at: 59) }
    }
    
}
