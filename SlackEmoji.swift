import Combine
import Foundation

final class SlackEmojiFetcher: ObservableObject {
    private static let apiUrlString = "https://slack.com/api/emoji.list?token="
    let objectWillChange = PassthroughSubject<Void, Never>()

    var emojiStore : [String: Emoji] = [:]

    init(token : String) {
        guard let url: URL = URL(string: SlackEmojiFetcher.apiUrlString + token) else { return }
         URLSession.shared.dataTask(with: url) { (data, response, error) in
             do {
                guard let json = data else { return }
                let swift = try JSONDecoder().decode(EmojiResponse.self, from: json)
                DispatchQueue.main.async {
                    for emojiRow in swift.emoji {
                        self.emojiStore[":\(emojiRow.key):"] = Emoji(emoji: ":\(emojiRow.key):", url: URL(string: emojiRow.value)!)
                    }
                    
                    self.objectWillChange.send()
                }
             }
             catch {
                 print(error)
             }
         }
        .resume()
    }
}
