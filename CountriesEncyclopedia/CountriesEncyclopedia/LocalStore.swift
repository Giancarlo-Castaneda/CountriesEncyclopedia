import Foundation
import SwiftData

struct LocalStore {

    let modelContext: ModelContext
    var modelContainer: ModelContainer = {
        let schema = Schema([
            FavoriteCountry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()


    // MARK: - Initialization
    
    @preconcurrency @MainActor
    init() {
        self.modelContext = modelContainer.mainContext
    }
    
    // MARK: - Internal Methods

    func saveContext() {
        do {
            try modelContext.save()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
