//
//  VerseView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct VerseView: View {
    var body: some View {
        CustomView(title: .verse, tabIcon: .book, tabTitle: .verse) {
        Text("Verse")
        }
    }
}

struct VerseView_Previews: PreviewProvider {
    static var previews: some View {
        VerseView()
    }
}
