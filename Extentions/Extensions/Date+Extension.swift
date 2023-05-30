//
//  Date+Extension.swift
//  Extentions
//
//  Created by Akshay Kumar on 30/05/23.
//

import Foundation

enum AppDateFormatter: String {
   // case dayAlphabatic = "d", year = "yyyy", monthWithYear = "MMMM yyyy"
    case dayAlphabatic = "d", year = "yyyy", monthWithYear = "MMMM yyyy", month = "MMM"
}

public enum DateComparisonType {
    
    // Days
    /// Checks if date today.
    case isToday
    /// Checks if date is tomorrow.
    case isTomorrow
    /// Checks if date is yesterday.
    case isYesterday
    /// Compares date days
    case isSameDay(asDate: Date)
    
    // Weeks
    
    /// Checks if date is in this week.
    case isThisWeek
    /// Checks if date is in next week.
    case isNextWeek
    /// Checks if date is in last week.
    case isLastWeek
    /// Compares date weeks
    case isSameWeek(asDate: Date)
    
    // Months
    
    /// Checks if date is in this month.
    case isThisMonth
    /// Checks if date is in next month.
    case isNextMonth
    /// Checks if date is in last month.
    case isLastMonth
    /// Compares date months
    case isSameMonth(asDate: Date)
    
    // Years
    
    /// Checks if date is in this year.
    case isThisYear
    /// Checks if date is in next year.
    case isNextYear
    /// Checks if date is in last year.
    case isLastYear
    /// Compare date years
    case isSameYear(asDate: Date)
    
    // Relative Time
    
    /// Checks if it's a future date
    case isInTheFuture
    /// Checks if the date has passed
    case isInThePast
    /// Checks if earlier than date
    case isEarlier(than: Date)
    /// Checks if later than date
    case isLater(than: Date)
    /// Checks if it's a weekday
    case isWeekday
    /// Checks if it's a weekend
    case isWeekend
    
}

// The date components available to be retrieved or modifed
public enum DateComponentType {
    case second, minute, hour, day, weekday, nthWeekday, week, month, year
}

public enum DateForType {
    case startOfDay, endOfDay, startOfWeek, endOfWeek, startOfMonth, endOfMonth, tomorrow, yesterday, nearestMinute(minute: Int), nearestHour(hour: Int)
}

extension Date {
    
    internal static let weekInSeconds: Double = 604800
    internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    
    func dateFor(_ type: DateForType, calendar: Calendar = Calendar.current) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        case .endOfWeek:
            let offset = 7 - component(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            let month = (component(.month) ?? 0) + 1
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset: 1)
        case .yesterday:
            return adjust(.day, offset: -1)
        case .nearestMinute(let nearest):
            let minutes = (component(.minute)! + nearest/2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (component(.hour)! + nearest/2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    
    func component(_ component: DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    
    func adjust(_ component: DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        dateComp.calendar = Calendar.current
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .nthWeekday:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    func compare(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isToday:
            return compare(.isSameDay(asDate: Date()))
        case .isTomorrow:
            let comparison = Date().adjust(.day, offset: 1)
            return compare(.isSameDay(asDate: comparison))
        case .isYesterday:
            let comparison = Date().adjust(.day, offset: -1)
            return compare(.isSameDay(asDate: comparison))
        case .isSameDay(let date):
            return component(.year) == date.component(.year)
                && component(.month) == date.component(.month)
                && component(.day) == date.component(.day)
        case .isThisWeek:
            return self.compare(.isSameWeek(asDate: Date()))
        case .isSameWeek(let date):
            if component(.week) != date.component(.week) {
                return false
            }
            // Ensure time interval is under 1 week
            return abs(self.timeIntervalSince(date)) < Date.weekInSeconds
        case .isNextWeek:
            let comparison = Date().adjust(.week, offset: 1)
            return compare(.isSameWeek(asDate: comparison))
        case .isLastWeek:
            let comparison = Date().adjust(.week, offset: -1)
            return compare(.isSameWeek(asDate: comparison))
        default:
            return self.compareMonth(comparison)
        }
    }
    
    private func compareMonth(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isThisMonth:
            return self.compare(.isSameMonth(asDate: Date()))
        case .isNextMonth:
            let comparison = Date().adjust(.month, offset: 1)
            return compare(.isSameMonth(asDate: comparison))
        case .isLastMonth:
            let comparison = Date().adjust(.month, offset: -1)
            return compare(.isSameMonth(asDate: comparison))
        case .isSameMonth(let date):
            return component(.year) == date.component(.year) && component(.month) == date.component(.month)
        default:
            return self.compareYear(comparison)
        }
    }
    
    private func compareYear(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isThisYear:
            return self.compare(.isSameYear(asDate: Date()))
        case .isNextYear:
            let comparison = Date().adjust(.year, offset: 1)
            return compare(.isSameYear(asDate: comparison))
        case .isLastYear:
            let comparison = Date().adjust(.year, offset: -1)
            return compare(.isSameYear(asDate: comparison))
        case .isSameYear(let date):
            return component(.year) == date.component(.year)
        default:
            return self.compareFuture(comparison)
        }
    }
    
    func compareFuture(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isInTheFuture:
            return self.compare(.isLater(than: Date()))
        case .isInThePast:
            return self.compare(.isEarlier(than: Date()))
        case .isEarlier(let date):
            return (self as NSDate).earlierDate(date) == self
        case .isLater(let date):
            return (self as NSDate).laterDate(date) == self
        case .isWeekday:
            return !compare(.isWeekend)
        case .isWeekend:
            let range = Calendar.current.maximumRange(of: Calendar.Component.weekday)!
            return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
        default:
            return false
        }
    }
    
    func getDaysInMonth() -> Int{
        let calendar = Calendar.current

        let dateComponents = DateComponents(year: calendar.component(.year, from: self), month: calendar.component(.month, from: self))
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        return numDays
    }
    
    func getFormattedStringFromDate(for formatter: AppDateFormatter) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter.rawValue
        return dateFormatter.string(from: self)
    }
}
