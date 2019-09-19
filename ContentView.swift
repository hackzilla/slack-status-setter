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

//struct SettingView: View {
//    var body: some View {
//        VStack {
//            Text("SwiftUI")
//            Divider()
//            Text("SwiftUI")
//            Divider()
//            Text("SwiftUI")
//        }
//        .navigationBarTitle(Text("Settings"), displayMode: .inline)
//    }
//}

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
    @ObservedObject var settings = UserSettings()
    @State private var statuses : [Status] = [
        Status(id: 0, emoji: ":spiral_calendar_pad:", description: "In a meeting", expireHours: 1),
        Status(id: 1, emoji: ":car:", description: "Commuting", expireHours: 12),
        Status(id: 2, emoji: ":computer:", description: "Working remotely", expireHours: 12),
        Status(id: 3, emoji: ":palm_tree:", description: "On holiday", expireHours: 0),
        Status(id: 4, emoji: ":house_with_garden:", description: "Working from home", expireHours: 12),
        Status(id: 5, emoji: ":slack:", description: "Building something awesome!", expireHours: 48),
    ]
    
    var body: some View {
        return NavigationView {
            List {
                ForEach(statuses) { myStatus in
                    HStack {
                        URLImage(self.slackController.emojiUrl(emoji: myStatus.emoji), configuration: ImageLoaderConfiguration(delay: 0.25))
                        .resizable()
                        .frame(width: 50.0, height: 50.0)
                        .clipped()
                        Text(myStatus.description)
                        Text(String(myStatus.expireHours) + " hours")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                }
//                .onDelete(perform: delete)
            }
            .navigationBarTitle(Text("Statuses"))
//            .navigationBarItems(
//                trailing:
//                NavigationLink(destination: EditView(status: myStatus)) {
//                    Image(systemName: "gear")
//                }
//            )
        }
    }
    
    mutating func add() {
//        statuses.append(Status)
    }
    
    mutating func delete(at offsets: IndexSet) {
        statuses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
