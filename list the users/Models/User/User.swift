//
//  User.swift
//  list the users
//
//  Created by Steven Hertz on 2/8/23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id:             Int
    var locationId:     Int
    var deviceCount:    Int
    var email:          String
    var groupIds:       Array<Int>
    var groups:         Array<String>
    var firstName:      String
    var lastName:       String
    var username:       String
    var notes:          String
    var modified:       String
}


extension User {
    static func makeDefault() -> User {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let year = components.year!
        let month = components.month!
        let day = components.day!
        let hour = components.hour!
        let minute = components.minute!
        let second = components.second!

        let startOfToday = DateComponents(calendar: calendar, year: year, month: month, day: day).date!
        let elapsedTime = date.timeIntervalSince(startOfToday)

        let totalSeconds = Int(elapsedTime) + (hour * 60 * 60) + (minute * 60) + second

//        print("Total seconds from the start of today: \(totalSeconds)")

        
        return User(id: totalSeconds, locationId: ApiHelper.globalLocationId, deviceCount: 0, email: "", groupIds: [], groups: [""], firstName: "", lastName: "", username: "", notes: "", modified: "")
    }
}

