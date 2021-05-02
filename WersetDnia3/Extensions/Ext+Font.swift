//  Created by Tymoteusz Stokarski on 12/11/2020.
//

import SwiftUI

extension Font {
    
    static var smallText: Font {
        .system(size: 13, weight: .medium, design: .rounded)
    }
    
    static var text: Font {
        .system(size: 16, weight: .medium, design: .rounded)
    }
    
    static var boldedText: Font {
        .system(size: 16, weight: .semibold, design: .rounded)
    }
    
    static var sectionHeader: Font {
        .system(size: 16, weight: .semibold, design: .rounded)
    }
    
    static var navigation: Font {
        .system(size: 30, weight: .bold, design: .default)
    }
    
    static var header1: Font {
        .system(size: 36, weight: .semibold, design: .rounded)
    }
    
    static var header2: Font {
        .system(size: 30, weight: .semibold, design: .rounded)
    }
    
    static var header3: Font {
        .system(size: 20, weight: .semibold, design: .rounded)
    }
    
    static var header3Regular: Font {
        .system(size: 18, weight: .medium, design: .rounded)
    }
    
}
