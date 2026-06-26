import SwiftData

extension ModelContainer {
    static let appContainer: ModelContainer = {
        let schema = Schema([SavedMovie.self])
        
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        return try! ModelContainer(for: schema, configurations: config)
    }()

}
