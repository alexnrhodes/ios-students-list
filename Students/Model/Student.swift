//
//  Student.swift
//  Students
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation


// Codeable = is a compound protocol, so it conforms to encodeable and decodeable. This object (student) should be able to be encoded and decoded from our JSON file. You can do this for multiple file types.

// Servers don't speak swift, so we have to take our data, in this case students, and make it readable to the server. Defacto standard is JSON. JSON is a a data interchange format, so read and uderstood by a vast majority of programming languages.

struct Student: Codable {
    var name: String
    var course: String
    
    var firstName: String {
        // Split allows you to take a string and devide it by a character. COOL. Our Seperator is space. Terrible code because we are assuming a lot. Like the user only has two names, doesn't use a hyphen, ect.
        return String(name.split(separator: " ")[0])
    }
    
    var lastName: String {
        // ?? default value, better to store name sperately rather than together. Each has their own data source.
        return String(name.split(separator: " ").last ?? "")
    }
}


