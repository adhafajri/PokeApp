//
//  CoreDataService.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation
import CoreData

protocol CoreDataService {
    var container: NSPersistentContainer { get }
    func save() throws
    func fetch<T>(request: NSFetchRequest<T>) throws -> [T] where T: NSFetchRequestResult
    func delete(object: NSManagedObject) throws
    func deleteAll(entityName: String)
}

struct CoreDataServiceImpl: CoreDataService {
    var container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "PokeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func create<T>(entityName: String, from dictionary: [String: Any]) throws -> T where T: NSManagedObject {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: container.viewContext) else {
            throw NSError(domain: "Entity not found", code: 404)
        }
        
        let object = T(entity: entity, insertInto: container.viewContext)
        
        for (key, value) in dictionary {
            object.setValue(value, forKey: key)
        }
        
        return object
    }
    
    func save() throws {
        guard container.viewContext.hasChanges else { return }
        
        try container.viewContext.performAndWait {
            do {
                try container.viewContext.save()
            } catch {
                throw error
            }
        }
    }
    
    func fetch<T>(request: NSFetchRequest<T>) throws -> [T] where T: NSFetchRequestResult {
        return try container.viewContext.fetch(request)
    }
    
    func delete(object: NSManagedObject) throws {
        container.viewContext.delete(object)
        try save()
    }
    
    func deleteAll(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            try save()
        } catch let error as NSError {
            print(error)
        }
    }
}
