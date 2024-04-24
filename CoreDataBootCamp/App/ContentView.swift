//
//  ContentView.swift
//  CoreDataBootCamp
//
//  Created by Amish on 24/04/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<FruitEntity>
    
    @FetchRequest(
        entity: FruitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)]
    ) var fruits: FetchedResults<FruitEntity>
    @State private var text: String = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type a fruit...", text: $text)
                    .padding()
                Button {
                    addItem()
                } label: {
                    Text("Add")
                }
                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                updateItems(fruit: fruit)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Fruit", systemImage: "plus")
                        }
                    }
                }
                .navigationTitle("Core Data ✍️")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            if text == "" {
                newFruit.name = "No Fruit"
            } else {
                newFruit.name = text
            }
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
            saveItems()
            text = ""
        }
    }
    
    private func updateItems(fruit: FruitEntity) {
        withAnimation {
            let currentName = fruit.name ?? ""
            let newName = currentName + "!!!!!!!"
            fruit.name = newName
            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
            guard let index = offsets.first else { return }
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
