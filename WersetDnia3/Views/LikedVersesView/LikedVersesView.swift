//
//  LikedVersesView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct LikedVersesView: View {
    
    var verses: [FirebaseVerse] = []
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(verses) { verse in
                    Text("")
                }
            }
        }
    }
    
    
}

struct LikedVersesView_Previews: PreviewProvider {
    static var previews: some View {
        LikedVersesView(verses: [])
    }
}
