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

struct RowView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData

    let myStatus : Status
    var isEditing: Bool

    var body: some View {
      HStack {
            URLImage(self.slackController.emojiStore[myStatus.emoji] ?? self.slackController.missingImage, delay: 0.25)
            //                .resizable()
                .frame(width: 50.0, height: 50.0, alignment: .leading)
                .clipped()
            Text(myStatus.description)
        
        }
    }
}
