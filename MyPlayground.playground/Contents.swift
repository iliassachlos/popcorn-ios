import Foundation
import PlaygroundSupport

// Keep the playground running while the async call completes
PlaygroundPage.current.needsIndefiniteExecution = true

let token = "your_read_access_token_here"
let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week")!

var request = URLRequest(url: url)
request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
request.setValue("application/json", forHTTPHeaderField: "Accept")

Task {
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Pretty print the raw JSON
        if let json = try? JSONSerialization.jsonObject(with: data),
           let pretty = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let string = String(data: pretty, encoding: .utf8) {
            print(string)
        }
    } catch {
        print("Error: \(error)")
    }
    
    PlaygroundPage.current.finishExecution()
}
