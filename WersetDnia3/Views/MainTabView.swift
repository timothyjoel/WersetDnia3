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

struct CustomView<Content>: View where Content: View {
    
    let title: ViewTitle
    let tabIcon: Icon
    let tabTitle: TabViewTitle
    let content: () -> Content

    init(title: ViewTitle, tabIcon: Icon, tabTitle: TabViewTitle, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.tabIcon = tabIcon
        self.tabTitle = tabTitle
        self.content = content
    }

    var body: some View {
        
        ZStack {
            Color(.systemBackground).ignoresSafeArea(.all)
            content()
            
        }
        .navigationBarTitle(Text(title.text))
        .tabItem {
            Image(icon: tabIcon)
            Text(text: tabTitle)
        }
        
    }
    
}

