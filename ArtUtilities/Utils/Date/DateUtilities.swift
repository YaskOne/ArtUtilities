//
//  DateUtilities.swift
//  ArtUtilities
//
//  Created by Arthur Ngo Van on 8/29/18.
//  Copyright © 2018 Arthur Ngo Van. All rights reserved.
//

import Foundation

public extension Date {
    
    // return number of minutes since now
    public func minutesSinceNow() -> Double {
        return timeIntervalSinceNow / 60
    }
    
    public func dateInMinutes(_ minutes: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    public func getISO8601() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        formatter.locale = Locale(identifier: NSLocale.current.languageCode ?? "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    public static func dateFromString(date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        formatter.locale = Locale(identifier: NSLocale.current.languageCode ?? "en_US_POSIX")
        return formatter.date(from: date)
    }
    
    public func formatDate(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
        formatter.locale = Locale(identifier: NSLocale.current.languageCode ?? "en_US_POSIX")
        return formatter.string(from: self)
    }
}
