//
//  Status.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Foundation

struct Status: Identifiable {
    let id : Int;
    let emoji : String;
    let description : String;
    let expireHours : Int;
}
