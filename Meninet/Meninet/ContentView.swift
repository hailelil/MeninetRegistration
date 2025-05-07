import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @State private var loggedInUsername = ""

    var body: some View {
        if isLoggedIn {
            MainView(isLoggedIn: $isLoggedIn)
                .environment(\.managedObjectContext, viewContext)
        } else {
            LoginView(isLoggedIn: $isLoggedIn, loggedInUsername: $loggedInUsername)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
