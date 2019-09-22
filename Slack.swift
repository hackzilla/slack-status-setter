//
//  Slack.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class Slack {
    @EnvironmentObject var userData: UserData

    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var emojiStore : [String: Emoji] = [:] {
       willSet {
           objectWillChange.send()
       }
    }

    private static let apiUrlString = "https://slack.com/api/emoji.list?token="
    
    private let clientId = "";
    private let clientSecret = "";

    init() {
        guard let url: URL = URL(string: Slack.self.apiUrlString + UserData().apiToken) else { return }

         URLSession.shared.dataTask(with: url) { (data, response, error) in
             do {
                guard let json = data else { return }
                print(json)
                let swift = try JSONDecoder().decode(EmojiResponse.self, from: json)
                DispatchQueue.main.async {
                    print(swift.emoji)
                    for emojiRow in swift.emoji {
                        self.emojiStore[":\(emojiRow.key):"] = Emoji(emoji: ":\(emojiRow.key):", url: URL(string: emojiRow.value)!)
                    }
                    
                    print(self.emojiStore)
                    self.objectWillChange.send()
                }
             }
             catch {
                 print(error)
                
             }
         }
        .resume()
    }
    
    func setStatus(text: String, emoji: String)
    {
        guard let profileData = try? JSONEncoder().encode(StatusRequest(status_text: text, status_emoji: emoji)) else {
            print("Error UploadData: ")
            return
        }
        
        var urlComponents = URLComponents(string: "https://slack.com/api/users.profile.set")!

        urlComponents.queryItems = [
            URLQueryItem(name: "profile", value: String(data: profileData, encoding: .utf8)),
            URLQueryItem(name: "token", value: UserData().apiToken),
        ]
        
        var request = URLRequest(url: (urlComponents.url!))
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    
    func emojis() -> [String: Emoji]
    {
        return self.emojiStore
    }
    
    func emojiUrl(emoji: String) -> URL
    {
        if (self.emojiStore.index(forKey: emoji) == nil) {
            print("Missing: \(emoji)");
            return URL(fileReferenceLiteralResourceName: "questions.jpg");
        }
        else if (emoji.hasPrefix("alias:")) {
            return self.emojiUrl(emoji: String(emoji.dropFirst(5)) + ":")
        }
        
        return self.emojiStore[emoji]!.url;
    }
}
