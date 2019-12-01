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

struct ContentView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData
    @State var isEditing: Bool = false

    var body: some View {
        return NavigationView {
            List {
                ForEach(self.userData.statuses) { myStatus in
                    if (!self.isEditing) {
                        RowView(myStatus: myStatus, isEditing: self.isEditing)
                        .onTapGesture {
                            self.slackController.setStatus(status: myStatus)
                        }
                    } else {
                        RowView(myStatus: myStatus, isEditing: self.isEditing)
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
                
                Button(action: {
                    self.slackController.clearStatus()
                }) {
                    Text("Clear current status")
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
