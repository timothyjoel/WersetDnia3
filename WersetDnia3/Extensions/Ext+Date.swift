//
//  Date+Ext.swift
//  WersetDnia3
//
//  Created by Tymoteusz Stokarski on 20/03/2021.
//

import Foundation

extension Date {

    var isLeapYear: Bool { Calendar.current.range(of: .day, in: .year, for: self)!.count == 366 }
    
    var string: String  {
        let dateFormatter =  DateFormatter()
        dateFormatter.locale = Locale(identifier: "pl_PL")
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
    
    var tommorrow: Date {
        return self.sameTimeDay(inDirection: .forward, using: .current)
    }
    
    var yesterday: Date {
        return self.sameTimeDay(inDirection: .backward, using: .current)
    }
    
    private func sameTimeDay(
        inDirection direction: Calendar.SearchDirection = .forward,
        using calendar: Calendar = .current
    ) -> Date {
        let components = calendar.dateComponents(
            [.hour, .minute, .second, .nanosecond],
            from: self
        )
        
        return calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: direction
        )!
    }
    

}
