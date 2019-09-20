//
//  Slack.swift
//  Status Setter
//
//  Created by Daniel Platt on 18/09/2019.
//  Copyright © 2019 Daniel Platt. All rights reserved.
//

import Foundation

class Slack {
    private let token = "<Your token here>";
    private let clientId = "";
    private let clientSecret = "";
    private var emojisList : [String: Emoji] = [:];
    
    init() {
        let fetcher = SlackEmojiFetcher(token: self.token);
        self.emojisList = fetcher.emojiStore;
    }
    
//    func updateEmoji(emojis: [String: Any]?) -> Void
//    {
//        print(emojis as Any);
//
//
//    }
    
    func setStatus(text: String, emoji: String)
    {
        guard let profileData = try? JSONEncoder().encode(StatusRequest(status_text: text, status_emoji: emoji)) else {
            print("Error UploadData: ")
            return
        }
        
        var urlComponents = URLComponents(string: "https://slack.com/api/users.profile.set")!

        urlComponents.queryItems = [
            URLQueryItem(name: "profile", value: String(data: profileData, encoding: .utf8)),
            URLQueryItem(name: "token", value: self.token),
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
        return self.emojisList
    }
    
    func emojiUrl(emoji: String) -> URL
    {
        print(emojisList)
        if (emojisList.index(forKey: emoji) == nil) {
            return URL(fileReferenceLiteralResourceName: "questions.jpg");
        }
        
        return emojisList[emoji]!.url;
    }
}
