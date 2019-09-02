//
//  Student.swift
//  Students
//
//  Created by Andrew R Madsen on 8/5/18.
//  Copyright © 2018 Lambda Inc. All rights reserved.
//

import Foundation


// Codeable = is a compound protocol, so it conforms to encodeable and decodeable. This object (student) should be able to be encoded and decoded from our JSON file. You can do this for multiple file types.

struct Student: Codable {
    var name: String
    var course: String
}


