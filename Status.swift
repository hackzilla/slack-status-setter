//
//  Status.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Foundation

struct Status: Equatable, Hashable, Codable, Identifiable {
    let id : UUID;
    let emoji : String;
    let description : String;
    let expireHours : Int;
    
    init(emoji: String, description : String, expireHours : Int) {
        self.id = UUID()
        self.emoji = emoji;
        self.description = description;
        self.expireHours = expireHours;
    }
}
