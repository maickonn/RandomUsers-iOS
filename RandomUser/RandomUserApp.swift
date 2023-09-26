import SwiftUI

@main
struct RandomUserApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UserListView()
            }
        }
    }
}
