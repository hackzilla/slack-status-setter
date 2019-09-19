//
//  UserSettings.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Combine
import SwiftUI

final class UserSettings: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()

    @UserDefault("Statuses", defaultValue: [])
    var statuses: [Status] {
        didSet {
            didChange.send()
        }
    }
    
    @UserDefault("ApiToken", defaultValue: "")
    var apiToken: String {
        didSet {
            didChange.send()
        }
    }
}
