//
//  CoreDataStack.swift
//  DolarBlue
//
//  Created by Max Ward on 11/08/2022.
//

import Foundation
import CoreData

enum FetchError: Error {
    case unknown
    case parsingError
}

class CoreDataStack {
    
    // Constructor privado para evitar la creación de instancias fuera de la clase.
    private init() {}
    
    // Variable estática que representa la instancia única y compartida de la clase.
    static let shared = CoreDataStack()
    
    // Variable que representa el contenedor persistente de la base de datos de Core Data.
    private var persistentContainer: NSPersistentContainer = {
        // Crea una instancia de NSPersistentContainer con el nombre de la base de datos.
        let container = NSPersistentContainer(name: "DolarBlue")
        // Carga el almacén persistente de Core Data y maneja cualquier error que pueda ocurrir.
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("error creating store container")
            }
        }
        // Devuelve el contenedor persistente.
        return container
    }()
    
    // Variable que representa el contexto en el que se realizan las operaciones de lectura y escritura.
    lazy var context: NSManagedObjectContext = {
        // Crea un contexto secundario que se ejecuta en segundo plano.
        return self.persistentContainer.newBackgroundContext()
    }()
    
    // Función que se utiliza para guardar los cambios realizados en el contexto de Core Data.
    @discardableResult
    func saveContext() async throws -> Bool {
        // Verifica si hay cambios en el contexto.
        guard context.hasChanges else {
            return false
        }
        do {
            // Intenta guardar los cambios en la base de datos.
            try self.context.save()
            // Devuelve verdadero para indicar que los cambios se guardaron correctamente.
            return true
        } catch {
            // Imprime un mensaje de error y devuelve falso si no se pudieron guardar los cambios.
            print("General error")
            return false
        }
    }
    
    // Función que se utiliza para recuperar objetos de la base de datos que coinciden con la solicitud especificada.
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) async throws -> [T]? {
        // Ejecuta la solicitud especificada en el contexto y devuelve los resultados.
        let results = try? self.context.fetch(request)
        return results
    }
    
    // Función que se utiliza para borrar todos los objetos en una tabla especificada.
    func clear(_ tableName: String) async throws {
        // Crea una solicitud de eliminación para la tabla especificada.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: tableName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            // Ejecuta la solicitud de eliminación en lote para borrar los objetos.
            try context.execute(batchDeleteRequest)
        } catch {
            // Lanza una excepción si no se pudieron borrar los objetos.
            throw APIError.emptyData
        }

    }

}
