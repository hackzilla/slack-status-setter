//
//  ContentView.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

// https://stackoverflow.com/questions/56822195/how-do-i-use-userdefaults-with-swiftui

import Combine
import Foundation
import SwiftUI
//import URLImage

struct SetStatusView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData

    let myStatus : Status
    var clearStatus = [
        "Never",
//        "30 minutes",
        "1 hour",
        "4 hours",
        "Today",
        "This week",
    ]
    
    @State private var selectedMode = 0

    var body: some View {
        return Form {
            Section {
                Text(myStatus.description)
                
                Picker(selection: $selectedMode, label: Text("Clear after")) {
                    ForEach(0 ..< clearStatus.count) {
                        Text(self.clearStatus[$0])
                    }
                }
            }
            
            //
            Button(action: {
                var expireHours : Int = 0;
                let now = Date()
                let calendar = Calendar.current
                
                switch self.selectedMode {
                    case 1:
                        expireHours = 1;
                        break;
                    case 2:
                        expireHours = 4;
                        break;
                    case 3:
                        let components = DateComponents(calendar: calendar, hour: 24)
                        let midnight = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTime)!
                        let diff = calendar.dateComponents([.hour], from: now, to: midnight)
                        
                        expireHours = diff.hour ?? 1;
                        break;
                    case 4:
                        let formatter = DateFormatter()
                        formatter.dateFormat = "EEEE"
                  
                        let diff = calendar.dateComponents([.hour], from: now, to: formatter.date(from: "Monday") ?? Date())
                        
                        expireHours = diff.hour ?? 1;
                        break;

                    default:
                        expireHours = 0;
                }
                
                let customStatus = Status(emoji: self.myStatus.emoji, description: self.myStatus.description, expireHours: expireHours)
                self.slackController.setStatus(status: customStatus)
            }) {
                Text("Set Status")
                    .foregroundColor(.blue)
                    .frame(alignment: .center)

            }
        }
        .navigationBarTitle(Text("Set Status"), displayMode: .inline)
    }
}
