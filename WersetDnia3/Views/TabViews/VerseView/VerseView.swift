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
            
            .navigationBarItems(leading:
                                    NavigationLink(destination: EmptyView()) {
                                        VerseStatisticsView(vm: vm)
                                    }
                                , trailing: Button(action: {
                                    vm.showToday()
                                }, label: {
                                    Text("Dzisiaj")
                                        .foregroundColor(Color(.systemPink))
                                })
            )
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

struct VerseStatisticsView: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        
        HStack (alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
            Image(icon: .heart)
                .foregroundColor(Color(.systemPink))
            Text("\(vm.verses?[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].likes ?? 0)")
                .foregroundColor(Color(.label))
            Image(icon: .message)
                .foregroundColor(Color(.systemPink))
            Text("\(vm.verses?[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].comments?.count ?? 0)")
                .foregroundColor(Color(.label))
        })
        
    }
}
