//
//  VerseVerseSectionView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import SwiftUI

struct VerseVerseSectionView: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        ZStack {
            
            HStack {

                VStack (alignment: .leading, spacing: 4, content: {
                    Text(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].path )
                        .foregroundColor(Color.customPink)
                        .font(.sectionHeader)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Text(vm.verses[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].text )
                        .foregroundColor(Color(.label))
                        .font(.text)
                        .multilineTextAlignment(.leading)
                })
                Spacer()
            }
            .padding()
            .background(RoundedCorners())

        }

        .padding(.horizontal)
        
    }
}

struct VerseVerseSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            VerseVerseSectionView(vm: VerseViewModel()).preferredColorScheme($0)
        }
        
    }
}
