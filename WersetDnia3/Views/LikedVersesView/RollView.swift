//
//  FunFactView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct RollView: View {
    var body: some View {
        NavigationViewBasic(title: .roll, tabIcon: .questionMark, tabTitle: .roll) {
        Text("Fun fact view")
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
