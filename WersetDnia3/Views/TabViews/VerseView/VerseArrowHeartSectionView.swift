//
//  VerseArrowHeartSectionView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 22/03/2021.
//

import SwiftUI

struct VerseArrowHeartSectionView: View {
    
    @ObservedObject var vm: VerseViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                vm.show(.backward)
            }, label: {
                Image(image: .leftArrow)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.systemPink))
                    .frame(width: 70.0, height: 70.0)
            })
            Spacer()
            Button(action: {
                vm.tapHeartButton()
            }, label: {
                HeartAnimationView(vm: vm, animation: .heart)
                    .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
            Spacer()
            Button(action: {
                vm.show(.forward)
            }, label: {
                Image(image: .rightArrow)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color(.systemPink))
                    .frame(width: 70, height: 70)
            })
        }
    }
    
}

struct VerseArrowHeartSectionView_Previews: PreviewProvider {
    static var previews: some View {
        VerseArrowHeartSectionView(vm: VerseViewModel())
    }
}
