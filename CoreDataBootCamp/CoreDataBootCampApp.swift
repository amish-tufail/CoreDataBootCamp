//
//  CoreDataBootCampApp.swift
//  CoreDataBootCamp
//
//  Created by Amish on 24/04/2024.
//

import SwiftUI

@main
struct CoreDataBootCampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
