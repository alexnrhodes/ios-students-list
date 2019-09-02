//
//  StudentController.swift
//  Students
//
//  Created by Ben Gohlke on 6/17/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import Foundation

class StudentController {
    
    private var persistentFileURL: URL? {
        guard let filePath = Bundle.main.path(forResource: "students", ofType: "json") else { return nil }
        return URL(fileURLWithPath: filePath)
    }
    
    // Closures are a functions that you can pass into other methods. The @escaping is a closure!
    func loadFromPersistentStore(completion: @escaping ([Student]?, Error?) -> Void) {
        
        // Constantly checking the information in the file, to update the view in accordance to the user.
        // The more queues added to the core, the more work the core has to do.
        let bgQueue = DispatchQueue(label: "studentQueue", attributes: .concurrent)
        
        bgQueue.async {
            // The work we want to complete in the background thread.
            let fm = FileManager.default
            guard let url = self.persistentFileURL, // computed property
                fm.fileExists(atPath: url.path) else {return} // gets the path?
            
            // If that works(guard) DO this
            do {
                
                // we have to try because the data initializer can throw an error. CATASCROPHIC failure. LMAO
                // the correct term is marshalling information from JSON to Data
                
                let data = try Data(contentsOf: url) // converting contents of json file to Data
                let decoder = JSONDecoder() // decoded using a cool decoder, lots less work than used to be
                let students = try decoder.decode([Student].self, from: data) // is suppose to retrieve an array of the student data from JSON
                completion(students, nil) // all the work we need to do is complete. Completion is the parameter!
            
            // If we do have that fatal error we will catch it and execute this code. An uncaught error is a crash!
            } catch {
                
                print("Error loading students data: \(error)")
                completion(nil, error)
                
            }
        }
    }
}
