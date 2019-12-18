//
//  StatusRequest.swift
//  Status Setter
//
//  Created by Daniel Platt on 19/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Foundation

struct StatusRequest: Codable {
    let status_text: String
    let status_emoji: String
}
