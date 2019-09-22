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

struct SettingView: View {
    @EnvironmentObject var userData: UserData

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
    @ObservedObject private var slackController = Slack()

    @State var emoji: String;
    @State var description: String;
    
    var body: some View {
        return Form {
            Section {
                Picker(selection: self.$emoji, label: Text("\(self.emoji)")) {
                    ForEach(0 ..< self.slackController.emojiArray.count) {
//                        HStack {
                            URLImage(self.slackController.emojiArray[$0].url, configuration: ImageLoaderConfiguration(delay: 0.25))
                            .resizable()
                            .frame(width: 50.0, height: 50.0, alignment: .leading)
                            .clipped()
                            .tag(self.slackController.emojiArray[$0].emoji)
//                            Text(self.slackController.emojiArray[$0].emoji)
//                        }
                    }
                }
                
                TextField("", text: self.$description)

            }
        }
        .navigationBarTitle(Text("Edit Status"), displayMode: .inline)
    }
}

struct ContentView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData
    @State var isEditing: Bool = false

    var body: some View {
        return NavigationView {
            List {
                ForEach(self.userData.statuses) { myStatus in
                    HStack {
                        URLImage(self.slackController.emojiStore[myStatus.emoji] ?? self.slackController.missingImage, configuration: ImageLoaderConfiguration(delay: 0.25))
                            .resizable()
                            .frame(width: 50.0, height: 50.0, alignment: .leading)
                            .clipped()
                        Text(myStatus.description)
                                
                        if (self.isEditing) {
                            NavigationLink(destination: EditView(emoji: myStatus.emoji, description : myStatus.description)) {
                                Text("")
                            }
                        } else {
//                            if (myStatus.expireHours > 0) {
//                                Text(String(myStatus.expireHours)! + " hours")
//                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                            } else {
                                Text("Never")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
//                            }
                        }
                    }
                    .onTapGesture {
                        if (!self.isEditing) {
                            self.slackController.setStatus(text: myStatus.description, emoji: myStatus.emoji)
                        }
                    }
                }
                .onDelete(perform: delete)

                Button(action: {
                    self.userData.statuses.append(
                        Status(emoji: ":slack:", description: "Being inspired", expireHours: 1)
                    )
                }) {
                    Text("Add new status")
                        .foregroundColor(.blue)
                        .frame(alignment: .center)

                }
                NavigationLink(destination: SettingView()) {
                    Text("Settings")
                    Image(systemName: "gear")
                }
            }
            .navigationBarTitle(Text("Statuses"))
            .navigationBarItems(
                trailing: Button(action: { self.isEditing.toggle() }) {
                if !self.isEditing {
                    Text("Edit")
                } else {
                    Text("Done").bold()
                }
            })
        }
    }
      
    func delete(at offsets: IndexSet) {
        self.userData.statuses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
