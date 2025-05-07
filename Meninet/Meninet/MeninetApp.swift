//
//  MeninetApp.swift
//  Meninet
//
//  Created by HLD on 16/05/2024.
//
/*
import SwiftUI

@main
struct MeninetApp:  App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
*/

//coredata
/*
import SwiftUI
import CoreData

@main
struct MeninetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Meninet")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
}
*/
import SwiftUI
import CoreData

@main
struct MeninetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create some mock data for preview
        for i in 0..<10 {
            let newUser = RegisteredUser(context: viewContext)
            newUser.firstName = "First \(i)"
            newUser.fatherName = "Father \(i)"
            newUser.grandFatherName = "Grandfather \(i)"
            newUser.identityNumber = "\(i)"
            newUser.phoneNumber = "1234567890"
        }

        for i in 0..<11 {
            let newService = Service(context: viewContext)
            newService.name = "Service \(i)"
            newService.isRunning = i < 9 // 9 services are running
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Meninet")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
}

