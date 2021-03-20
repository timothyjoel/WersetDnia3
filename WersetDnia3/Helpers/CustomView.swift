//
//  CustomView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

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
