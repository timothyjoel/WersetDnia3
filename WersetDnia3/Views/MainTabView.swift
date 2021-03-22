//
//  HomeView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selectedTab: Int = 2
    
    var body: some View {
        
        TabView(selection: .constant(selectedTab),
                content:  {
                    AlarmView()
                        .tag(0)
                    RollView()
                        .tag(1)
                    VerseView()
                        .tag(2)
                    LikedVersesView()
                        .tag(3)
                    InfoView()
                        .tag(4)
                })
            .accentColor(Color(.label))
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
