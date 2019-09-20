//
//  UserData.swift
//
//  Bits copied from Suyeol Jeon on 03/06/2019.
//  Copyright © 2019 Suyeol Jeon. All rights reserved.
//

import Combine
import SwiftUI

private let defaultStatuses: [Status] = [
    Status(emoji: ":spiral_calendar_pad:", description: "In a meeting", expireHours: 1),
    Status(emoji: ":car:", description: "Commuting", expireHours: 12),
    Status(emoji: ":computer:", description: "Working remotely", expireHours: 12),
    Status(emoji: ":palm_tree:", description: "On holiday", expireHours: 0),
    Status(emoji: ":house_with_garden:", description: "Working from home", expireHours: 12),
    Status(emoji: ":slack:", description: "Building something awesome!", expireHours: 48),
]

final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()

    @UserDefault(key: "ApiToken", defaultValue: "")
    var apiToken: String {
        didSet {
            didChange.send(self)
        }
    }
    
    @UserDefault(key: "Statuses", defaultValue: defaultStatuses)
    var statuses: [Status] {
        didSet {
            didChange.send(self)
        }
    }
}
