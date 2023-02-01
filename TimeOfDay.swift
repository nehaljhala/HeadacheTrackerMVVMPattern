//
//  TimeOfDay.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 3/16/22.
//

import Foundation

enum TimeOfDay: Equatable {
    case morning(hour: Date)
    case afternoon(hour: Date)
    case evening(hour: Date)
    case unknown
    
    var hour: String {
        switch self {
        case .morning(_):
            return "Morning"
        case .afternoon(_):
            return "Afternoon"
        case .evening(_):
            return "Evening"
        case .unknown:
            return "-"
        }
    }
}

extension Date {

    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let updatedDate = Double ()
        let interval = Date() - updatedDate
        
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }

    
}
