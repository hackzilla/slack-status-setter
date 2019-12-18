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

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    let editStatus : Status

    private var emoji: State<String>;
    private var description: State<String>;
    
    init(status: Status) {
        self.editStatus = status;
        self.emoji = .init(initialValue: self.editStatus.emoji)
        self.description = .init(initialValue: self.editStatus.description)
    }
    
    var body: some View {
        return Form {
            Section {
//                Picker(selection: self.$emoji, label: Text("\(self.emoji)")) {
//                    ForEach(0 ..< self.slackController.emojiArray.count) {
////                        HStack {
//                            URLImage(self.slackController.emojiArray[$0].url, configuration: ImageLoaderConfiguration(delay: 0.25))
//                            .resizable()
//                            .frame(width: 50.0, height: 50.0, alignment: .leading)
//                            .clipped()
//                            .tag(self.slackController.emojiArray[$0].emoji)
////                            Text(self.slackController.emojiArray[$0].emoji)
////                        }
//                    }
//                }
                
                TextField("Emoji e.g. :car:", text: self.emoji.projectedValue)
                TextField("Status text", text: self.description.projectedValue)
            }
            
            Button(action: {
                guard let index = self.userData.statuses.firstIndex(of: self.editStatus) else { return }
                self.userData.statuses[index] = Status(emoji: self.emoji.wrappedValue, description: self.description.wrappedValue, expireHours: 0) ;
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .foregroundColor(.blue)
                    .frame(alignment: .center)

            }
        }
        .navigationBarTitle(Text("Edit Status"), displayMode: .inline)
    }
}
