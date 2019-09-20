//
//  ContentView.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

// https://stackoverflow.com/questions/56822195/how-do-i-use-userdefaults-with-swiftui
// https://mecid.github.io/2019/06/19/building-forms-with-swiftui/

import Combine
import SwiftUI
import URLImage

struct SettingView: View {
    @ObservedObject var userData = UserData()

    var body: some View {
        Form {
            Section {
                Text("Slack API Token")
                TextField("Slack API Token", text: $userData.apiToken)
            }
            Section {
                Button(action: {
//                    self.settings.apiToken = self.apiToken
                }) {
                    Text("Save changes")
                }
            }
        }
        .navigationBarTitle(Text("Settings"), displayMode: .inline)
    }
}

struct EditView: View {
    var status: Status

    var body: some View {
        VStack {
            Text("SwiftUI")
            Divider()
            Text("SwiftUI")
            Divider()
            Text("SwiftUI")
        }
        .navigationBarTitle(Text("Edit"), displayMode: .inline)
    }
}

struct ContentView: View {
    private var slackController = Slack()
    @ObservedObject var userData = UserData()

    var body: some View {
        return NavigationView {
            List {
                ForEach(self.userData.statuses) { myStatus in
                    HStack {
                        URLImage(self.slackController.emojiUrl(emoji: myStatus.emoji), configuration: ImageLoaderConfiguration(delay: 0.25))
                            .resizable()
//                            .frame(width: 50.0, height: 50.0, alignment: .leading)
                            .clipped()
                        Text(myStatus.description)
                        Text(String(myStatus.expireHours) + " hours")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
//                    .onDelete(perform: delete)

                }
                Spacer()
                Button(action: {
                    self.userData.statuses.append(
                        Status(emoji: ":slack:", description: "Being inspired", expireHours: 1)
                        )
                    print(self.userData.statuses)
                }) {
                    Text("Add new status")
                        
                }
            }
            .navigationBarTitle(Text("Statuses"))
            .navigationBarItems(
                trailing:
                NavigationLink(destination: SettingView()) {
                    Image(systemName: "gear")
                }
            )
        }
    }
      
    mutating func delete(at offsets: IndexSet) {
        userData.statuses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
