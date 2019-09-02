//
//  MainViewController.swift
//  Students
//
//  Created by Alex Rhodes on 9/2/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    
    private let studentController = StudentController()
    
    private var students: [Student] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // students, error in represents the students array (optional), and error (optional) a built in iOS class. Read documentation on error class!
        studentController.loadFromPersistentStore { students, error in
            
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == ""  {
            guard let destination = segue.destination as? StudentsTableViewController else {return}
        }
        
    }
}
