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
                .tabItem {
                    Text(text: .alarm)
                    Image(icon: .alarm)
                }
            RollView()
                .tabItem {
                    Text(text: .roll)
                    Image(icon: .questionMark)
                }
            VerseView()
                .tabItem {
                    Text(text: .verse)
                    Image(icon: .book)
                }
            LikedVersesView()
                .tabItem {
                    Text(text: .likedVerse)
                    Image(icon: .star)
                }
            InfoView()
                .tabItem {
                    Text(text: .info)
                    Image(icon: .info)
                }
            
        }
        .accentColor(Color(.label))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

//struct AlarmView: View {
//    var body: some View {
//        Text("Alarm view!")
//    }
//}
//
//struct AlarmView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmView()
//    }
//}
