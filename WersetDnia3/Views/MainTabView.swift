//
//  HomeView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        
        TabView {
            AlarmView()
            RollView()
            VerseView()
            LikedVersesView()
            InfoView()
            
        }
        .accentColor(Color(.label))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
