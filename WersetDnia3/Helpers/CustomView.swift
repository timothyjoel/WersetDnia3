//
//  CustomView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct NavigationViewBasic<Content>: View where Content: View {
    
    // MARK: - Properties
    
    let title: ViewTitle
    let tabIcon: Icon
    let tabTitle: TabViewTitle
    let content: () -> Content

    // MARK: - Initializers
    
    init(title: ViewTitle, tabIcon: Icon, tabTitle: TabViewTitle, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.tabIcon = tabIcon
        self.tabTitle = tabTitle
        self.content = content
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemBackground).ignoresSafeArea(.all)
                content()
            }
            .navigationBarTitle(Text(title.text))
        }
        .tabItem {
            Image(icon: tabIcon)
            Text(text: tabTitle)

        }
        
    }
    
}
