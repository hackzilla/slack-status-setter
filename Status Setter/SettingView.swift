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

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData

    var body: some View {
        Form {
            Section {
                Text("Slack API Token")
                TextField("Slack API Token", text: $userData.apiToken)
            }
            Section {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
//                    self.settings.apiToken = self.apiToken
                }) {
                    Text("Save changes")
                }
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
    }
}
