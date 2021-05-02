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
    
    private let databaseManager = DatabaseManager.shared
    
    @Published var verses: [FirebaseVerse]?
    @Published var date = Date()
    
    // MARK: - Iniitializers
    
    init() {
        self.loadData()
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
            guard Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 0 < verses?.count ?? 0 else { return }
            date = date.tommorrow
        default: break
        }
    }
    
    func tapStar() {
        print("tap")
        guard let verses = verses else { return }
        guard let index = Calendar.current.ordinality(of: .day, in: .year, for: date) else { return }
        verses[index].likedLocally ? likeVerse(false) : likeVerse(true)
        print("tapped")
    }
    
    
    // MARK: - Private methods
    
    private func loadData() {
        databaseManager.load { [weak self] verses in
            self?.verses = verses
            self?.adjustToLeapYear()
        }
    }
    
    private func adjustToLeapYear() {
        if date.isLeapYear { self.verses?.remove(at: 59) }
    }
    
    private func likeVerse(_ like: Bool) {
        guard let verses = verses else { return }
        guard let index = Calendar.current.ordinality(of: .day, in: .year, for: date) else { return }
        self.verses?[index].likedLocally = like
        self.verses?[index].likes += like ? 1 : -1
        like ? databaseManager.add(like: verses[index]) : databaseManager.remove(like: verses[index])
    }
    
}
