//
//  VerseView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI
import Combine

struct VerseView: View {
    
    @ObservedObject var vm = VerseViewModel()
    
    var body: some View {
        
        NavigationViewBasic(title: .verse, tabIcon: .book, tabTitle: .verse) {
            VStack(alignment: .center, spacing: 16, content: {
                VerseVerseSectionView(vm: vm)
                Spacer()
                VerseArrowHeartSectionView(vm: vm)
                
            })
            .padding(.top)
            .padding(.bottom)
            .navigationBarItems(trailing: Button(action: {
                    vm.showToday()
                }, label: {
                    Text("Dzisiaj")
                        .foregroundColor(Color(.systemPink))
                }))
        }
        
    }
    
}

struct VerseView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VerseView().preferredColorScheme($0)
        }
    }
}
