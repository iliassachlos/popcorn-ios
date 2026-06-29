import Foundation

enum Secrets {
    static var apiKey: String {
        return valueGuard(key: "ApiKey")
    }
    
    private static func valueGuard(key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String, !value.isEmpty else {
            fatalError("Missing API key: \(key)")
        }
        
        return value
    }
}
