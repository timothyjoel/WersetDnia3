//
//  LikedVersesView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct LikedVersesView: View {
    var body: some View {
        CustomView(title: .likedVerse, tabIcon: .star, tabTitle: .likedVerse) {
            Text("Liked verses")
        }
    }
}

struct LikedVersesView_Previews: PreviewProvider {
    static var previews: some View {
        LikedVersesView()
    }
}
