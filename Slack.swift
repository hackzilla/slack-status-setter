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

class Slack: ObservableObject {
    @EnvironmentObject var userData: UserData

    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var emojiStore : [String: URL] = [:] {
       willSet {
           objectWillChange.send()
       }
    }
    
    @Published var emojiArray : [Emoji] = [] {
       willSet {
           objectWillChange.send()
       }
    }
    
    let missingImage : URL = URL(fileReferenceLiteralResourceName: "questions.jpg")
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
                    var aliasEmoji: [String : String] = [:]
                    
                    for emojiRow in swift.emoji {
                        if (emojiRow.key.hasPrefix("alias:")) {
                            aliasEmoji[emojiRow.key] = emojiRow.value;
                            continue;
                        }
                            
                        self.emojiStore[":\(emojiRow.key):"] = URL(string: emojiRow.value)!
                    }
                    
                    for (key, value) in aliasEmoji {
                        let emojiURL : URL = self.emojiStore[value.dropFirst(5) + ":"]!
                        self.emojiStore[":\(key):"] = emojiURL
//                        self.emojiArray.append(Emoji(emoji: ":\(key):", url: emojiURL))
                    }

                    for key in self.emojiStore.keys.sorted() {
                        self.emojiArray.append(Emoji(emoji: key, url: self.emojiStore[key]!))
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
    
    func setStatus(status: Status)
    {
        let emoji: String = status.emoji
        let text: String = status.description

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
    
    func emojiUrl(emoji: String) -> URL
    {
        if (self.emojiStore.index(forKey: emoji) == nil) {
            print("Missing: \(emoji)");
            return self.missingImage;
        }
        else if (emoji.hasPrefix("alias:")) {
            return self.emojiUrl(emoji: String(emoji.dropFirst(5)) + ":")
        }
        
        return self.emojiStore[emoji] ?? self.missingImage;
    }
}
