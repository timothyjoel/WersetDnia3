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
        VStack (alignment: .center, spacing: 16, content: {
            Text(vm.date.string)
                .foregroundColor(Color(.systemPink))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text(vm.verses?[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].path ?? "")
                .foregroundColor(Color(.label))
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Text(vm.verses?[Calendar.current.ordinality(of: .day, in: .year, for: vm.date) ?? 0].text ?? "")
                .foregroundColor(Color(.label))
                .font(.title3)
                .multilineTextAlignment(.center)
        })
        .padding(.horizontal)
    }
}

struct VerseVerseSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VerseVerseSectionView(vm: VerseViewModel())
    }
}
