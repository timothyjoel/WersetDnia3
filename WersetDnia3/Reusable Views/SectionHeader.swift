//
//  SectionHeaderView.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 31/03/2021.
//

import SwiftUI

struct SectionHeader: View {
    
    var title: String
    
    var body: some View {
        HStack() {
            Text(title)
                .font(.sectionHeader)
                .foregroundColor(.customSectionTitle)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    
   static var previews: some View {
    
        Group {
            SectionHeader(title: "Title")
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")

            SectionHeader(title: "Title")
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
                .environment(\.colorScheme, .dark)
      }
    
   }
    
}
