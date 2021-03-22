//
//  InfoView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationViewBasic(title: .info, tabIcon: .info, tabTitle: .info) {
        Text("Info view")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
