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
    
    private var studentsTableViewController: StudentsTableViewController! {
        didSet {
            updateDataSource()
        }
    }
    
    private var students: [Student] = [] {
        didSet { // any time the student property is changed, the didSet is run.
            updateDataSource()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // `students, error in` represents the students array (optional), and error (optional) a built in iOS class. Read documentation on error class!
        
        studentController.loadFromPersistentStore { students, error in // this closure is being preformed on a background thread.
            
            // checking to see if error has a value, and if so something is obvs wrong.
            if let error = error {
                print("Errot loading students: \(error)")  // you can also issue an alert to the user.
                return
            }
            
            // Line = 38 reaching into the queue to get the array of students, and store it in our student property.
            
            DispatchQueue.main.async { // we use this because both calls in studentController are in the bgQueue.async method (a backgroung thread), so we need to move the work back over to the main thread. Any code that affects the UI that code has to run on the main thread.
                
                self.students = students ?? [] // using self.students makes sure the compiler understands the students we are referring is the property in the current view.
            }
            
            // from first brace to here is a closure. Closures are designer for future use.. pass them as a future set of instructions. When this method is called, we are going to pass along the closure to be run at a future time. 
        }
        
    }
    
    @IBAction func sortSegmentedControl(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    
    @IBAction func filterSegmentedControl(_ sender: UISegmentedControl) {
        updateDataSource()
    }
    
    
    private func updateDataSource() {
        
        var sortedAndFilteredStudents: [Student]
        
        switch filterSegmentedControl.selectedSegmentIndex {
            
        case 1: // filter for iOS
            sortedAndFilteredStudents = students.filter { $0.course == "iOS" } // creating a new array of the filter of choice.
            
        case 2: // filter for iOS
            sortedAndFilteredStudents = students.filter { $0.course == "Web"}
            
        case 3: // filter for UX
            sortedAndFilteredStudents = students.filter { $0.course == "UX"}
            
        default:
            // filter for none, or any other number
            sortedAndFilteredStudents = students
        }
        
        if sortSegmentedControl.selectedSegmentIndex == 0 {
            // sort based on first name
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {
                $0.firstName < $1.firstName // alphabatizes array, for z to you would use >
            }
        } else {
            // sort based on last name
            sortedAndFilteredStudents = sortedAndFilteredStudents.sorted {
                $0.lastName > $1.lastName
            }
        }
        studentsTableViewController.students = sortedAndFilteredStudents
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this is allowing you to grab the embeded tableView
        studentsTableViewController = (segue.destination as! StudentsTableViewController)
        
    }
}
