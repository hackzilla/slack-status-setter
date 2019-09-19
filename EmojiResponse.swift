//
//  EmojiResponse.swift
//  Status Setter
//
//  Created by Daniel Platt on 19/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Foundation

struct EmojiResponse: Codable {
    var ok: Bool;
    var emoji : [String: String];
    var cache_ts: String;
}
