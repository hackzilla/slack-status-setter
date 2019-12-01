//
//  ContentView.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

// https://stackoverflow.com/questions/56822195/how-do-i-use-userdefaults-with-swiftui

import Combine
import SwiftUI
import URLImage

struct SetStatusView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData

    let myStatus : Status

    var body: some View {
        return Form {
            Section {
    
            Text(myStatus.description)
          }
            
            // self.slackController.setStatus(status: myStatus)
            Button(action: {
//                guard let index = self.userData.statuses.firstIndex(of: self.editStatus) else { return }
//                self.userData.statuses[index] = Status(emoji: self.emoji.wrappedValue, description: self.description.wrappedValue, expireHours: 0) ;
//                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Set Status")
                    .foregroundColor(.blue)
                    .frame(alignment: .center)

            }
        }
        .navigationBarTitle(Text("Set Status"), displayMode: .inline)
    }
}
