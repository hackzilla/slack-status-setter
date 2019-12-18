//
//  ContentView.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Combine
import SwiftUI
import URLImage

struct ContentView: View {
    @ObservedObject private var slackController = Slack()
    @EnvironmentObject var userData: UserData
    @State var isEditing: Bool = false

    var body: some View {
        VStack {
            Image("logo")
                .cornerRadius(20)
            Text("Status Setter")
                .font(.largeTitle)
            
            Button(action: {
            }) {
                Image("slack")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding([.leading, .trailing], 20)

        }
    }
      
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
