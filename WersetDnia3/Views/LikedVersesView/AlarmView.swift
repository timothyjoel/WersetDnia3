//
//  AlarmView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import SwiftUI

struct AlarmView: View {
    var body: some View {
        NavigationViewBasic(title: .alarm, tabIcon: .alarm, tabTitle: .alarm) {
            Text("Alarm")
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
